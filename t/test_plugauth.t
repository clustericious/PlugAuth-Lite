use strict;
use warnings;
BEGIN { eval q{ use File::HomeDir::Test } }
use Test::More;
BEGIN { plan skip_all => 'test requires Test::Clustericious::Config 0.26' unless eval q{ use Test::Clustericious::Config 0.26; 1 } }
BEGIN { plan skip_all => 'test requires Test::Clustericious 0.9930' unless eval q{ use Test::Clustericious 0.9930; 1 } }
use Test::PlugAuth;

plan tests => 5;

my $auth = Test::PlugAuth->new(auth => sub {
  my($user, $pass) = @_;
  return $user eq 'gooduser' && $pass eq 'goodpass';
});

eval '# line '. __LINE__ . ' "' . __FILE__ . qq("\n) . q{
  package MyApp;
  
  our $VERSION = '1.1';
  use base 'Clustericious::App';
  
  package MyApp::Routes;
  
  use Clustericious::RouteBuilder;
  
  authenticate;
  authorize;
  
  get '/private' => sub { shift->render(text => 'this is private') };
  
};
die $@ if $@;

create_config_ok 'MyApp', { plug_auth => { url => $auth->url } };

my $t = Test::Mojo->new('MyApp');
$auth->apply_to_client_app($t->app);

my $port = eval { $t->ua->server->url->port } // $t->ua->app_url->port;

$t->get_ok("http://baduser:badpass\@localhost:$port/private")
  ->status_is(401);

$t->get_ok("http://gooduser:goodpass\@localhost:$port/private")
  ->status_is(200);

