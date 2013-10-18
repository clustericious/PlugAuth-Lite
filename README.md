# PlugAuth::Lite [![Build Status](https://secure.travis-ci.org/plicease/PlugAuth-Lite.png)](http://travis-ci.org/plicease/PlugAuth-Lite)

Pluggable (lite) authentication and authorization server.

# SYNOPSIS

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

# DESCRIPTION

This distribution provides 

- [plugauthlite](http://search.cpan.org/perldoc?plugauthlite)

    [PlugAuth](http://search.cpan.org/perldoc?PlugAuth) compatible server in the form of a [Mojolicious::Lite](http://search.cpan.org/perldoc?Mojolicious::Lite) application.

- [Mojolicious::Plugin::PlugAuthLite](http://search.cpan.org/perldoc?Mojolicious::Plugin::PlugAuthLite)

    [Mojolicious](http://search.cpan.org/perldoc?Mojolicious) plugin that adds [PlugAuth](http://search.cpan.org/perldoc?PlugAuth) compatible routes to a new or 
    existing [Mojolicious](http://search.cpan.org/perldoc?Mojolicious) application.

- [PlugAuth::Lite](http://search.cpan.org/perldoc?PlugAuth::Lite)

    [Mojolicious](http://search.cpan.org/perldoc?Mojolicious) application with [PlugAuth](http://search.cpan.org/perldoc?PlugAuth) compatible routes that can be spawned
    from within a perl application.

In the future it will also contain a testing interface for testing authentication
and authorization rules in [Clustericious](http://search.cpan.org/perldoc?Clustericious) applications.

It has fewer prerequisites that the full fledged [PlugAuth](http://search.cpan.org/perldoc?PlugAuth) server (simply
[Mojolicious](http://search.cpan.org/perldoc?Mojolicious) and perl itself) but also fewer features (it notably lacks
the management interface).

# SEE ALSO

[plugauthlite](http://search.cpan.org/perldoc?plugauthlite),
[Mojolicious::Plugin::PlugAuthLite](http://search.cpan.org/perldoc?Mojolicious::Plugin::PlugAuthLite),
[Test::PlugAuth](http://search.cpan.org/perldoc?Test::PlugAuth),
[Clustericious](http://search.cpan.org/perldoc?Clustericious)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
