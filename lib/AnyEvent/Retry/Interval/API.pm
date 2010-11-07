package AnyEvent::Retry::Interval::API;
# ABSTRACT: API role that interval classes must implement
use Moose::Role;
use true;
use namespace::autoclean;

requires 'next';
requires 'reset';

__END__

=head1 SEE ALSO

L<AnyEvent::Retry::Interval>
