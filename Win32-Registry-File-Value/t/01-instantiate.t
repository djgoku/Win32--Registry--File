#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 18;
use Test::Exception;

use Win32::Registry::File::Value;

require_ok('Win32::Registry::File::Value');

my $value;
lives_ok { $value = Win32::Registry::File::Value->new() }
'Successfully created a Win32::R::F::V object';
isa_ok( $value, 'Win32::Registry::File::Value' );
isa_ok( $value, 'Moose::Object' );

my $value2;
lives_ok {
    $value2 = Win32::Registry::File::Value->new(
        type       => 'REG_SZ',
        value_name => 'ValueName',
        value_data => 'ValueData',
    );
}
'Successfully created a Win32::R::F::V object';
is( $value2->get_type,   'REG_SZ',    '...got the right type' );
is( $value2->get_value_name, 'ValueName', '...got the right value_name' );
is( $value2->get_value_data, 'ValueData', '...got the right value_data' );

can_ok( $value2, qw/check_type check_value_name check_value_data/ );

# Testing check_type()
is( $value2->check_type( $value2->get_type ), 1, 'REG_SZ is a valid value type' );
$value2->set_type('REG_BINARY');
is( $value2->get_type, 'REG_BINARY', 'we are able to set_type()' );
is( $value2->check_type( $value2->get_type ), 1, 'REG_BINARY is a valid value type' );
$value2->set_type('REG_DWORD');
is( $value2->check_type( $value2->get_type ), 1, 'REG_DWORD is a valid value type' );
$value2->set_type('REG_EXPAND_SZ');
is( $value2->check_type( $value2->get_type ), 1, 'REG_EXPAND_SZ is a valid value type' );
$value2->set_type('REG_MULTI_SZ');
is( $value2->check_type( $value2->get_type ), 1, 'REG_MULTI_SZ is a valid value type' );
$value2->set_type('FAIL');
is( $value2->check_type( $value2->get_type ), 0, 'FAIL is an invalid value type' );

# Testing check_value_name()
my $long_string = '_perl' x 51; # 5 * 51 = 255
$value2->set_value_name($long_string);
is( $value2->check_value_name( $value2->get_value_name ), 1, 'Value name is set to max characters allowed' );
$value2->set_value_name($long_string . 'F');
is( $value2->check_value_name( $value2->get_value_name ), 0, 'Value name exceeds max characters allowed' );
