package Test::PlugAuth;

use strict;
use warnings;
use v5.10;
use PlugAuth::Lite;
use Mojo::UserAgent;

# ABSTRACT: minimum PlugAuth server to test Clustericious apps against
# VERSION

sub new
{
  my $class = shift;
  my $config = ref $_[0] ? $_[0] : {@_};
  my $self = bless {}, $class;
  
  $self->{app} = PlugAuth::Lite->new($config);
  $self->{ua}  = Mojo::UserAgent->new;
  $self->ua->app($self->app);
  
  $self->{url} = $self->ua->app_url->to_string;
  $self->{url} =~ s{/$}{};
  
  return $self;
}

sub ua  { shift->{ua}  }
sub app { shift->{app} }
sub url { shift->{url} }

sub apply_to_client_app 
{
  my($self, $client_app) = @_;
  $client_app->helper(auth_ua => sub { $self->ua });
  return;
}

=head1 SYNOPSIS

assuming you have a Clustericious app MyApp with authentication/authorization
directives that you need to test:

 use Test::Clustericious::Config;
 use Test::Clustericious;
 use Test::PlugAuth;
 
 my $auth = Test::PlugAuth->new(auth => {
   my($user,$pass) = @_;
   return $user eq 'gooduser' && $pass eq 'goodpass';
 });
 
 create_config_ok 'MyApp', { plug_auth => $auth->url };
 
 $t = Test::Clustericious->new('MyApp');
 $auth->apply_to_client_app($t->app);
 
 my $port = $t->ua->app_url->port;
 
 $t->get_ok("http://baduser:badpass\@localhost:$port/private")
   ->status_is(401);
 $t->get_ok("http://gooduser:goodpass\@localhost:$port/private")
   ->status_is(200);

=head1 DESCRIPTION

Provides a way to test a Clustericious application with a fake PlugAuth server
with reduced boilerplate

=cut

1;
