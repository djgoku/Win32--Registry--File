#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 16;
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
is( $value2->value_name, 'ValueName', '...got the right value_name' );
is( $value2->value_data, 'ValueData', '...got the right value_data' );

can_ok( $value2, qw/check_type check_value_name check_value_data/ );

is( $value2->check_type( $value2->get_type ),
    1, 'checking for REG_SZ value type' );
$value2->set_type('REG_BINARY');
is( $value2->get_type, 'REG_BINARY', 'we are able to set_type()' );
is( $value2->check_type( $value2->get_type ),
    1, 'checking for REG_BINARY value type' );
$value2->set_type('REG_DWORD');
is( $value2->check_type( $value2->get_type ),
    1, 'checking for REG_DWORD value type' );
$value2->set_type('REG_EXPAND_SZ');
is( $value2->check_type( $value2->get_type ),
    1, 'checking for REG_EXPAND_SZ value type' );
$value2->set_type('REG_MULTI_SZ');
is( $value2->check_type( $value2->get_type ),
    1, 'checking for REG_MULTI_SZ value type' );
$value2->set_type('FAIL');
is( $value2->check_type( $value2->get_type ),
    0, 'checking for a FAIL value type' );
