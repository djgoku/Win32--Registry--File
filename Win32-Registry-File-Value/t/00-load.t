#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Win32::Registry::File::Value' );
}

diag( "Testing Win32::Registry::File::Value $Win32::Registry::File::Value::VERSION, Perl $], $^X" );
