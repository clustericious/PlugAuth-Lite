package PlugAuth::Lite;

use strict;
use warnings;
use v5.10;

# ABSTRACT: Pluggable (lite) authentication and authorization server.
# VERSION

=head1 SYNOPSIS

command line:

 % plugauthlite

Mojolicious (lite):

 use Mojolicious::Lite;
 
 plugin 'plug_auth_lite';

=head1 DESCRIPTION

This distribution provides a L<PlugAuth> compatible server in the form of
a Mojolicious lite application (L<plugauthlite>) and Mojolicious Plugin
(L<Mojolicious::Plugin::PlugAuthLite>).  In the future it will also contain
a testing interface for testing authentication and authorization rules
in L<Clustericious> applications.

It has fewer prerequisites that the full fledged L<PlugAuth> server (simply
L<Mojolicious> and perl itself) but also fewer features (it notably lacks
the management interface).  See the other modules in this distribution for
details.

=head1 SEE ALSO

L<plugauthlite>,
L<Mojolicious::Plugin::PlugAuthLite>,
L<Test::PlugAuth>,
L<Clustericious>

=cut

1;
