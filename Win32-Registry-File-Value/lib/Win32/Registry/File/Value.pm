package Win32::Registry::File::Value;

use Moose;

=head1 NAME

Win32::Registry::File::Value - The great new Win32::Registry::File::Value!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Win32::Registry::File::Value;

    my $foo = Win32::Registry::File::Value->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=cut

has 'type' => ( is => 'rw', isa => 'Str', );
has 'value_name' => ( is => 'rw', isa => 'Str', );
has 'value_data' => ( is => 'rw', isa => 'Str', );

=head1 AUTHOR

Jonathan C. Otsuka, C<< <djgoku at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-win32-registry-file-value at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Win32-Registry-File-Value>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Win32::Registry::File::Value


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Win32-Registry-File-Value>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Win32-Registry-File-Value>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Win32-Registry-File-Value>

=item * Search CPAN

L<http://search.cpan.org/dist/Win32-Registry-File-Value/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Jonathan C. Otsuka, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

no Moose;
__PACKAGE__->meta->make_immutable;

1; # End of Win32::Registry::File::Value
