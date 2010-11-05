package AnyEvent::Retry::Interval::Fibonacci;
# ABSTRACT: fibonacci back-off
use Moose;
use MooseX::Types::Common::Numeric qw(PositiveNum);

use Math::Fibonacci qw(term);

use namespace::autoclean;

with 'AnyEvent::Retry::Interval';

has 'scale' => (
    is      => 'ro',
    isa     => PositiveNum,
    default => 1.0,
);

sub reset {}

sub next {
    my ($self, $i) = @_;
    return $self->scale * term($i);
}

1;

__END__

=head1 SYNOPSIS

C<AnyEvent::Retry::Interval> that waits longer and longer after each
failed attempt.

=head1 INITARGS

=head2 scale

A number greater than 0 that the fibonacci number is multiplied by
before being returned.  For example, to wait 1 millisecond, then 1
millisecond, then 2 milliseconds, then 3 ..., pass C<scale => 1/1000>.

=head1 NOTES

The fibonacci number is computed with L<Math::Fibonacci>.  This may yield
slightly different results from the iterative C<F(n) = F(n-2) + F(n-1)>
method.
