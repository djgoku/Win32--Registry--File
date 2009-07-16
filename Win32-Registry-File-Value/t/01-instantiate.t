#!/usr/bin/perl -T

use strict;
use warnings;

use Test::More tests => 3;
use Test::Exception;

use Win32::Registry::File::Value;

my $value;
lives_ok {
    $value = Win32::Registry::File::Value->new();
}
'Successfully created a Win32::R::F::V object';
isa_ok( $value, 'Win32::Registry::File::Value' );
isa_ok( $value, 'Moose::Object' );

