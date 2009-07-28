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

has 'type' => (
    is     => 'rw',
    isa    => 'Str',
    reader => 'get_type',
    writer => 'set_type'
);
has 'value_name' => (
    is     => 'rw',
    isa    => 'Str',
    reader => 'get_value_name',
    writer => 'set_value_name',
);
has 'value_data' => (
    is     => 'rw',
    isa    => 'Str',
    reader => 'get_value_data',
    writer => 'set_value_data',
);

=head1 FUNCTIONS

=head2 before set_type()

=cut

before 'set_type' => sub {
  my ($self, $type) = @_;
  die "Invalid type was found \'$type\' when calling set_type()" unless $self->check_type($type); 
};

=head2 before set_value_name()

=cut

before 'set_value_name' => sub {
  my ($self, $value_name) = @_;
  die "Invalid value name was found \'$value_name\' when calling set_value_name" unless $self->check_value_name($value_name);
};

=head2 before set_value_data()

=cut

before 'set_value_data' => sub {
  my ($self, $value_data) = @_;
  die "Invalid value data was found \'$value_data\' when calling set_value_data" unless $self->check_value_data($value_data);
};

=head2 check_type

=cut

sub check_type {
    my ($self, $type) = @_;
    my %types = (
    REG_SZ        => 1,
    REG_BINARY    => 1,
    REG_DWORD     => 1,
    REG_EXPAND_SZ => 1,
    REG_MULTI_SZ  => 1,
    );

    return 1 if (defined($type) && exists($types{$type}));
    return 0;
}

=head2 check_value_name

The max value for a Value Name is 255 characters. Other than that 
there are no limitatiosn to the characters used that I know of.

=cut

sub check_value_name {
    my ($self, $value_name) = @_;
    if ( defined($value_name) && length( $value_name) >= 1 && length( $value_name ) <= 255 ) {
        return 1;
    }
    return 0;
}

=head2 check_value_data

=cut

sub check_value_data {
  my ($self, $type, $value_data) = @_;

  if(defined($type) && $self->check_type($type)) {
    if(defined($value_data) && $type eq 'REG_SZ') {
      return 1;
    } elsif(defined($value_data) && $type eq 'REG_DWORD') {
      return 1 if($value_data =~ /^dword:([[:xdigit:]]{8})$/);
      return 0;
    } elsif(defined($value_data) && $type eq 'REG_BINARY') {
      # trim newline
      $value_data =~ s/\R//g;

      # trim whitespace
      $value_data =~ s/\s+//g;

      return 0 if($value_data =~ /\\$/); # trailing backslashes are invalid
      
      $value_data =~ s/\\//g; # trim backslashes
      $value_data .= ',' unless($value_data =~ /,$/); # don't add a trailing comma if there is one already present

      return 1 if($value_data =~ /^hex:([[:xdigit:]]{2},)*$/ || $value_data =~ /^hex:,$/);
      return 0;
    }
  }
  return 0;
}

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

1;    # End of Win32::Registry::File::Value
