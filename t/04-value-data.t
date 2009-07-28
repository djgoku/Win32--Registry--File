#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 22;
use Test::Exception;

use Win32::Registry::File::Value;

my $value = Win32::Registry::File::Value->new();

# set_value_data()


# check_value_data()
my $long_string .= 'a1~`!1@2#3$4%5^6&7*8(9)0_-+={[}]|\:;"\'<,>.?/';
ok( $value->check_value_data( $long_string ) == 0, 'A type has to be passed to the subroutine' );
ok( $value->check_value_data( '', $long_string ) == 0, 'A valid type has to be passed to the subroutine' );
ok( $value->check_value_data( undef, $long_string ) == 0, 'A valid type has to be passed to the subroutine' );
ok( $value->check_value_data( 'REG_SZ', undef ) == 0, 'Valid \'REG_SZ\' type passed, we making sure something is passed for the data' );
ok( $value->check_value_data( 'REG_SZ', '\"\"' ) == 1, '\'REG_SZ\' this is the minimum data for a REG_SZ' );
ok( $value->check_value_data( 'REG_SZ', $long_string ) == 1, '\'REG_SZ\' this is somewhat large data for REG_SZ' );
ok( $value->check_value_data( 'REG_DWORD', '\"\"' ) == 0, '\'REG_DWORD\' can not have a empty string for a data value' );
ok( $value->check_value_data( 'REG_DWORD', 'dword:0123456' ) == 0, '\'REG_DWORD\' must have 8 hexadecimal values in the data' );
ok( $value->check_value_data( 'REG_DWORD', 'dword:gggghhhh' ) == 0, '\'REG_DWORD\' can not have non-hexadecimal values in data' );
ok( $value->check_value_data( 'REG_DWORD', 'dword:01234567' ) == 1, '\'REG_DWORD\' a valid all numeric data passed to subroutine' );
ok( $value->check_value_data( 'REG_DWORD', 'dword:89ABCDEF' ) == 1, '\'REG_DWORD\' a valid part numeric with A-F data passed to subroutine' );
ok( $value->check_value_data( 'REG_DWORD', 'Dword:00001111' ) == 0, '\'REG_DWORD\' no characters in dword are allowed to be capitalized' );
ok( $value->check_value_data( 'REG_DWORD', 'dword:012345678' ) == 0, '\'REG_DWORD\' too many (9) hexadicimal values in data' );
ok( $value->check_value_data( 'REG_BINARY', '\"\"') == 0, '\'REG_BINARY\' an empty string is not a valid string for data' );
ok( $value->check_value_data( 'REG_BINARY', 'hEx:') == 0, '\'REG_BINARY\' no characters in hex are allowed to be capitalized' );
ok( $value->check_value_data( 'REG_BINARY', 'hex:') == 1, '\'REG_BINARY\' this is a correct emptry string' );
ok( $value->check_value_data( 'REG_BINARY', 'hex:GG') == 0, '\'REG_BINARY\' can not have non-hexadecimal values in data');
ok( $value->check_value_data( 'REG_BINARY', 'hex:00') == 1, '\'REG_BINARY\' a very small (00) value for data');
ok( $value->check_value_data( 'REG_BINARY', 'hex:00,') == 1, '\'REG_BINARY\' a very small (00,) value for data');
ok( $value->check_value_data( 'REG_BINARY', 'hex:01,ab,cd,ef') == 1, '\'REG_BINARY\' using all hexadecimal values in data');
ok( $value->check_value_data( 'REG_BINARY', 'hex:00,11\\') == 0, '\'REG_BINARY\' trailing slash at the end ($) of string should fail');
ok( $value->check_value_data( 'REG_BINARY', 'hex:11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,\
  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,\
  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,bb,bb,aa,aa,bb,\
  bb,bb,bb') == 1, '\'REG_BINARY\' trailing slash at the end ($) of a multi-line string should fail');
