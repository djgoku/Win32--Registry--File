#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 21;
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

# set_value_name()
my $long_string = '_perl' x 51; # 5 * 51 = 255 is the max allow size for value_name
is( $value->set_value_name($long_string), $value->get_value_name, 'value_name set to a 255 character string');
dies_ok{ $value->set_value_name($long_string . 'F') } 'set_value_name() just died!!!';

# check_value_name()
is( $value->check_value_name( $long_string ), 1, 'Value name is set to max characters allowed' );
is( $value->check_value_name( $long_string . 'F' ), 0, 'Value name exceeds max characters allowed' );
