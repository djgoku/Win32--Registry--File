#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 7;
use Test::Exception;

use Win32::Registry::File::Value;

my $value = Win32::Registry::File::Value->new();

# set_value_name()
my $long_string = '_perl' x 51; # 5 * 51 = 255 is the max allow size for value_name
$value->set_value_name($long_string);
ok( $value->get_value_name eq $long_string, 'Max (255) characters allowed for a value name.');
dies_ok{ $value->set_value_name($long_string . 'F') } 'set_value_name() just died!!!';

# check_value_name()
ok( $value->check_value_name( 'a' ) == 1, 'A single character is enough for a value name' );
ok( $value->check_value_name( $long_string ) == 1, 'Max (255) characaters allowed for a value name' );
ok( $value->check_value_name( $long_string . 'F' ) == 0, 'Value name exceeds max allowed characters' );
ok( $value->check_value_name( '' ) == 0, 'Empty value name should return false' );
ok( $value->check_value_name( undef ) == 0, 'Undef value name should return false' );
