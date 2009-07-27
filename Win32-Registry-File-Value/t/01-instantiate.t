#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 48;
use Test::Exception;

use Win32::Registry::File::Value;

require_ok('Win32::Registry::File::Value');

my $value;
lives_ok { $value = Win32::Registry::File::Value->new() }
'Successfully created a Win32::R::F::V object';
isa_ok( $value, 'Win32::Registry::File::Value' );
isa_ok( $value, 'Moose::Object' );

can_ok( $value, qw/check_type check_value_name check_value_data/ );

# set_type()
is( $value->set_type('REG_SZ'), $value->get_type, 'type set to REG_SZ');
is( $value->set_type('REG_BINARY'), $value->get_type, 'type set to REG_BINARY');
is( $value->set_type('REG_DWORD'), $value->get_type, 'type set to REG_DWORD');
is( $value->set_type('REG_EXPAND_SZ'), $value->get_type, 'type set to REG_EXPAND_SZ');
is( $value->set_type('REG_MULTI_SZ'), $value->get_type, 'type set to REG_MULTI_SZ');
dies_ok { $value->set_type('FAIL') } 'set_type() just died!!!';

# check_type()
is( $value->check_type( 'REG_SZ' ), 1, 'REG_SZ is a valid value type' );
is( $value->check_type( 'REG_BINARY' ), 1, 'REG_BINARY is a valid value type' );
is( $value->check_type( 'REG_DWORD' ), 1, 'REG_DWORD is a valid value type' );
is( $value->check_type( 'REG_EXPAND_SZ' ), 1, 'REG_EXPAND_SZ is a valid value type' );
is( $value->check_type( 'REG_MULTI_SZ' ), 1, 'REG_MULTI_SZ is a valid value type' );
is( $value->check_type( 'FAIL' ), 0, 'FAIL is an invalid value type' );
is( $value->check_type( '' ), 0, 'empty string is an invalid value type' );
is( $value->check_type( undef ), 0, 'undef is an invalid value type' );

# set_value_name()
my $long_string = '_perl' x 51; # 5 * 51 = 255 is the max allow size for value_name
$value->set_value_name($long_string);
is( $value->get_value_name, $long_string, 'Max (255) characters allowed for a value name.');
dies_ok{ $value->set_value_name($long_string . 'F') } 'set_value_name() just died!!!';

# check_value_name()
is( $value->check_value_name( 'a' ), 1, 'A single character is enough for a value name' );
is( $value->check_value_name( $long_string ), 1, 'Max (255) characaters allowed for a value name' );
is( $value->check_value_name( $long_string . 'F' ), 0, 'Value name exceeds max allowed characters' );
is( $value->check_value_name( '' ), 0, 'Empty value name should return false' );
is( $value->check_value_name( undef ), 0, 'Undef value name should return false' );

# check_value_data()
$long_string .= 'a1~`!1@2#3$4%5^6&7*8(9)0_-+={[}]|\:;"\'<,>.?/';
is( $value->check_value_data( $long_string ), 0, 'A type has to be passed to the subroutine' );
is( $value->check_value_data( '', $long_string ), 0, 'A valid type has to be passed to the subroutine' );
is( $value->check_value_data( undef, $long_string ), 0, 'A valid type has to be passed to the subroutine' );
is( $value->check_value_data( 'REG_SZ', undef ), 0, 'Valid \'REG_SZ\' type passed, we making sure something is passed for the data' );
is( $value->check_value_data( 'REG_SZ', '\"\"' ), 1, '\'REG_SZ\' this is the minimum data for a REG_SZ' );
is( $value->check_value_data( 'REG_SZ', $long_string ), 1, '\'REG_SZ\' this is somewhat large data for REG_SZ' );
is( $value->check_value_data( 'REG_DWORD', '\"\"' ), 0, '\'REG_DWORD\' can not have a empty string for a data value' );
is( $value->check_value_data( 'REG_DWORD', 'dword:0123456' ), 0, '\'REG_DWORD\' must have 8 hexadecimal values in the data' );
is( $value->check_value_data( 'REG_DWORD', 'dword:gggghhhh' ), 0, '\'REG_DWORD\' can not have non-hexadecimal values in data' );
is( $value->check_value_data( 'REG_DWORD', 'dword:01234567' ), 1, '\'REG_DWORD\' a valid all numeric data passed to subroutine' );
is( $value->check_value_data( 'REG_DWORD', 'dword:89ABCDEF' ), 1, '\'REG_DWORD\' a valid part numeric with A-F data passed to subroutine' );
is( $value->check_value_data( 'REG_DWORD', 'Dword:00001111' ), 0, '\'REG_DWORD\' no characters in dword are allowed to be capitalized' );
is( $value->check_value_data( 'REG_DWORD', 'dword:012345678' ), 0, '\'REG_DWORD\' too many (9) hexadicimal values in data' );
is( $value->check_value_data( 'REG_BINARY', '\"\"'), 0, '\'REG_BINARY\' an empty string is not a valid string for data' );
is( $value->check_value_data( 'REG_BINARY', 'hEx:'), 0, '\'REG_BINARY\' no characters in hex are allowed to be capitalized' );
is( $value->check_value_data( 'REG_BINARY', 'hex:'), 1, '\'REG_BINARY\' this is a correct emptry string' );
is( $value->check_value_data( 'REG_BINARY', 'hex:GG'), 0, '\'REG_BINARY\' can not have non-hexadecimal values in data');
is( $value->check_value_data( 'REG_BINARY', 'hex:00'), 1, '\'REG_BINARY\' a very small (00) value for data');
is( $value->check_value_data( 'REG_BINARY', 'hex:00,'), 1, '\'REG_BINARY\' a very small (00,) value for data');
is( $value->check_value_data( 'REG_BINARY', 'hex:01,ab,cd,ef'), 1, '\'REG_BINARY\' using all hexadecimal values in data');
is( $value->check_value_data( 'REG_BINARY', 'hex:00,11\\'), 0, '\'REG_BINARY\' trailing slash at the end ($) of string should fail');
is( $value->check_value_data( 'REG_BINARY', 'hex:11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,\
  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,\
  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,bb,bb,aa,aa,bb,\
  bb,bb,bb'), 1, '\'REG_BINARY\' trailing slash at the end ($) of a multi-line string should fail');
