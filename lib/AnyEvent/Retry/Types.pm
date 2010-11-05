package AnyEvent::Retry::Types;
use strict;
use warnings;

use MooseX::Types -declare => ['Interval'];
use MooseX::Types::Moose qw(Str HashRef);

role_type Interval, { role => 'AnyEvent::Retry::Interval::API' };

sub class_name {
    my $str = shift;
    if(/^\+(.+)$/){
        return $1;
    }
    else {
        return "AnyEvent::Retry::Interval::$str";
    }
}

coerce Interval, from Str, via {
    my $name = class_name($_);
    Class::MOP::load_class($name);
    return $name->new;
};

coerce Interval, from HashRef, via {
    my $req = [keys %$_]->[0];
    my $args = $_->{$req};

    my $name = class_name($req);
    Class::MOP::load_class($name);
    return $name->new($args);
};

1;
