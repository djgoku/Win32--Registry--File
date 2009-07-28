#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

use Win32::Registry::File::Value;

require_ok('Win32::Registry::File::Value');

my $value;
lives_ok { $value = Win32::Registry::File::Value->new() }
'Successfully created a Win32::R::F::V object';
isa_ok( $value, 'Win32::Registry::File::Value' );
isa_ok( $value, 'Moose::Object' );

can_ok( $value, qw/check_type check_value_name check_value_data/ );
