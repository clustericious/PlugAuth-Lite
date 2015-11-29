# MOVED

This is the old version of [PlugAuth::Lite](https://metacpan.org/pod/PlugAuth::Lite) from before it was merged
into core [Test::Clustericious::Cluster](https://metacpan.org/pod/Test::Clustericious::Cluster).  Please see the [Test::Clustericious::Cluster](https://metacpan.org/pod/Test::Clustericious::Cluster) main repository
here: [https://github.com/clustericious/Test-Clustericious-Cluster](https://github.com/clustericious/Test-Clustericious-Cluster).

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

- [plugauthlite](https://metacpan.org/pod/plugauthlite)

    [PlugAuth](https://metacpan.org/pod/PlugAuth) compatible server in the form of a [Mojolicious::Lite](https://metacpan.org/pod/Mojolicious::Lite) application.

- [Mojolicious::Plugin::PlugAuthLite](https://metacpan.org/pod/Mojolicious::Plugin::PlugAuthLite)

    [Mojolicious](https://metacpan.org/pod/Mojolicious) plugin that adds [PlugAuth](https://metacpan.org/pod/PlugAuth) compatible routes to a new or 
    existing [Mojolicious](https://metacpan.org/pod/Mojolicious) application.

- [PlugAuth::Lite](https://metacpan.org/pod/PlugAuth::Lite)

    [Mojolicious](https://metacpan.org/pod/Mojolicious) application with [PlugAuth](https://metacpan.org/pod/PlugAuth) compatible routes that can be spawned
    from within a perl application.

In the future it will also contain a testing interface for testing authentication
and authorization rules in [Clustericious](https://metacpan.org/pod/Clustericious) applications.

It has fewer prerequisites that the full fledged [PlugAuth](https://metacpan.org/pod/PlugAuth) server (simply
[Mojolicious](https://metacpan.org/pod/Mojolicious) and perl itself) but also fewer features (it notably lacks
the management interface).

# ATTRIBUTES

## auth

Subroutine reference to call to check authentication.  Passes in `($user, $pass)` should
return true for authenticated, false otherwise.

If not provided, all authentications fail.

## authz

Subroutine reference to call to check authorization.  Passes in `($user, $action, $resource)`
and should return true for authorized, false otherwise.

If not provided, all authorizations succeed.

## host

Subroutine reference to call to check host information.

# SEE ALSO

[plugauthlite](https://metacpan.org/pod/plugauthlite),
[Mojolicious::Plugin::PlugAuthLite](https://metacpan.org/pod/Mojolicious::Plugin::PlugAuthLite),
[Test::PlugAuth](https://metacpan.org/pod/Test::PlugAuth),
[Clustericious](https://metacpan.org/pod/Clustericious)

# AUTHOR

Graham Ollis &lt;plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
