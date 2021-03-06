package PlugAuth::Lite;

use strict;
use warnings;
use v5.10;
use Mojo::Base qw( Mojolicious );

# ABSTRACT: Pluggable (lite) authentication and authorization server.
# VERSION

=head1 MOVED

This is the old version of L<PlugAuth::Lite> from before it was merged
into core L<Test::Clustericious::Cluster>.  Please see the L<Test::Clustericious::Cluster> main repository
here: L<https://github.com/clustericious/Test-Clustericious-Cluster>.

=head1 SYNOPSIS

command line:

 % plugauthlite

Mojolicious Plugin:

 use Mojolicious::Lite;
 
 plugin 'plug_auth_lite', 
   auth => sub {
     my($user, $pass) = @_;
     if($user eq 'optimus' && $pass eq 'matrix')
     { return 1; }
     else
     { return 0; }
   },
   authz => sub {
     my($user, $action, $resource) = @_;
     if($user eq 'optimus && $action eq 'open' && $resource =~ m{^/matrix})
     { return 1 }
     else
     { return 0 }
   };

Mojolicious App:

 use PlugAuth::Lite;
 my $app = PlugAuth::Lite->new({
   auth => sub {
     my($user, $pass) = @_;
     if($user eq 'optimus' && $pass eq 'matrix')
     { return 1; }
     else
     { return 0; }
   },
   authz => sub {
     my($user, $action, $resource) = @_;
     if($user eq 'optimus && $action eq 'open' && $resource =~ m{^/matrix})
     { return 1 }
     else
     { return 0 }
   },
 });

=head1 DESCRIPTION

This distribution provides 

=over 4

=item L<plugauthlite>

L<PlugAuth> compatible server in the form of a L<Mojolicious::Lite> application.

=item L<Mojolicious::Plugin::PlugAuthLite>

L<Mojolicious> plugin that adds L<PlugAuth> compatible routes to a new or 
existing L<Mojolicious> application.

=item L<PlugAuth::Lite>

L<Mojolicious> application with L<PlugAuth> compatible routes that can be spawned
from within a perl application.

=back

In the future it will also contain a testing interface for testing authentication
and authorization rules in L<Clustericious> applications.

It has fewer prerequisites that the full fledged L<PlugAuth> server (simply
L<Mojolicious> and perl itself) but also fewer features (it notably lacks
the management interface).

=head1 ATTRIBUTES

=head2 auth

Subroutine reference to call to check authentication.  Passes in C<($user, $pass)> should
return true for authenticated, false otherwise.

If not provided, all authentications fail.

=head2 authz

Subroutine reference to call to check authorization.  Passes in C<($user, $action, $resource)>
and should return true for authorized, false otherwise.

If not provided, all authorizations succeed.

=head2 host

Subroutine reference to call to check host information.

=cut

has 'auth';
has 'authz';
has 'host';

sub startup
{
  my($self, $config) = @_;

  $self->plugin('plug_auth_lite',
    auth  => $self->auth  // sub { 0 },
    authz => $self->authz // sub { 1 },
    host  => $self->host  // sub { 0 },
  );
}

1;

=head1 SEE ALSO

L<plugauthlite>,
L<Mojolicious::Plugin::PlugAuthLite>,
L<Test::PlugAuth>,
L<Clustericious>

=cut

