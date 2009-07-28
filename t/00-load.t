#!perl -T

use Test::More tests => 2;

BEGIN {
	use_ok( 'Win32::Registry::File::Value' );
}

BEGIN {
  use_ok( 'Win32::Registry::File' );
}

diag( "Testing Win32::Registry::File::Value $Win32::Registry::File::Value::VERSION, Perl $], $^X" );
