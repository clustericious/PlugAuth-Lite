package Mojolicious::Plugin::PlugAuthLite;

# ABSTRACT: Add a minimal PlugAuth server to your Mojolicious application.
# VERSION

use Mojo::Base qw( Mojolicious::Plugin );

sub register
{
  my($self, $app, $conf) = @_;
  return;
}

1;
