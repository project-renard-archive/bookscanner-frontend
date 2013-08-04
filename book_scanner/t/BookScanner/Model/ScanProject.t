use Test::Most tests => 4;
use strict;

BEGIN { use_ok( 'BookScanner::Model::ScanProject' ); }

use BookScanner::Model::ScanDirectory;

my $tmpdir = File::Temp->newdir;

my $sd = BookScanner::Model::ScanDirectory->new( directory => $tmpdir );

my $project;
ok( $project = $sd->get_project( 'project' ) );

is( @{$project->scans}, 0, 'no scans' );

$project->new_scan for 0..2;

is( @{$project->scans}, 3, '3 scans' );


done_testing;
