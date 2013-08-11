use Test::Most;
use strict;

BEGIN { use_ok( 'BookScanner::Model::Scanner::IPWebcam' ); }
require_ok( 'BookScanner::Model::Scanner::IPWebcam' );

my $webcam;

ok( $webcam = BookScanner::Model::Scanner::IPWebcam->new() );

$webcam->address('http://192.168.1.1:8080');
is( $webcam->mjpeg_url, "http://192.168.1.1:8080/video");

done_testing;
