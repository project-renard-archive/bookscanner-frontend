use Test::Most tests => 6;
use File::Temp;
use Path::Class;
use strict;

BEGIN { use_ok( 'BookScanner::Model::ScanDirectory' ); }

my $sd;
my $tmpdir = File::Temp->newdir;

ok( $sd = BookScanner::Model::ScanDirectory->new( directory => $tmpdir ) );

$sd->get_project('a');
$sd->get_project('b');
sleep 1; # allow for a second later
$sd->get_project('c');

is( @{$sd->projects}, 3, 'three directories');
is( dir($sd->most_recent_project->directory)->basename, 'c' );

sleep 1;
$sd->get_project('0');
is( @{$sd->projects}, 4, 'four directories');
is( dir($sd->most_recent_project->directory)->basename, '0' );


done_testing;

