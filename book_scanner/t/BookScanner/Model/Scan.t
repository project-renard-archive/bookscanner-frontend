use Test::Most tests => 6;
use strict;

BEGIN { use_ok( 'BookScanner::Model::Scan' ); }

use BookScanner::Model::ScanDirectory;

my $tmpdir = File::Temp->newdir;
my $sd = BookScanner::Model::ScanDirectory->new( directory => $tmpdir );

my $project0 = $sd->get_project('project');
my $project1 = $sd->get_project('project');


my $scan0 = $project0->new_scan;

is( @{$project0->scans}, 1 );
is( @{$project1->scans}, 1 );

my $scan1_test = $project1->scans->[0];

is( $scan1_test->creation_time, $scan0->creation_time );

sleep 1;

my $scan_sametime_0 = $project0->new_scan;
my $scan_sametime_1 = $project1->new_scan;

# THIS MAY FAIL AND THAT'S OK!
like( $scan_sametime_1->filename , qr/0000/ );

is( @{$project1->scans}, 3 );


done_testing;

