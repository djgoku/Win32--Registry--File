#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 14;
use Test::Exception;

use Win32::Registry::File::Value;

my $value = Win32::Registry::File::Value->new();

# set_type()
ok( $value->set_type('REG_SZ') eq $value->get_type, 'type set to REG_SZ');
ok( $value->set_type('REG_BINARY') eq $value->get_type, 'type set to REG_BINARY');
ok( $value->set_type('REG_DWORD') eq $value->get_type, 'type set to REG_DWORD');
ok( $value->set_type('REG_EXPAND_SZ') eq $value->get_type, 'type set to REG_EXPAND_SZ');
ok( $value->set_type('REG_MULTI_SZ') eq $value->get_type, 'type set to REG_MULTI_SZ');
dies_ok { $value->set_type('FAIL') } 'set_type() just died!!!';

# check_type()
ok( $value->check_type( 'REG_SZ' ) == 1, 'REG_SZ is a valid value type' );
ok( $value->check_type( 'REG_BINARY' ) == 1, 'REG_BINARY is a valid value type' );
ok( $value->check_type( 'REG_DWORD' ) == 1, 'REG_DWORD is a valid value type' );
ok( $value->check_type( 'REG_EXPAND_SZ' ) == 1, 'REG_EXPAND_SZ is a valid value type' );
ok( $value->check_type( 'REG_MULTI_SZ' ) == 1, 'REG_MULTI_SZ is a valid value type' );
ok( $value->check_type( 'FAIL' ) == 0, 'FAIL is an invalid value type' );
ok( $value->check_type( '' ) == 0, 'empty string is an invalid value type' );
ok( $value->check_type( undef ) == 0, 'undef is an invalid value type' );
