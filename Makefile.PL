use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Win32::Registry::File',
    AUTHOR              => 'Jonathan C. Otsuka <djgoku@gmail.com>',
    VERSION_FROM        => 'lib/Win32/Registry/File.pm',
    ABSTRACT_FROM       => 'lib/Win32/Registry/File.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Win32-Registry-File-*' },
);
