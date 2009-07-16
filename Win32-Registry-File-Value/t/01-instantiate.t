#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 7;
use Test::Exception;

use Win32::Registry::File::Value;

my $value;
lives_ok { $value = Win32::Registry::File::Value->new() },
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
}, 'Successfully created a Win32::R::F::V object';
is( $value2->type, 'REG_SZ', '...got the right type' );
is( $value2->value_name, 'ValueName', '...got the right value_name');
is( $value2->value_data, 'ValueData', '...got the right value_data');
