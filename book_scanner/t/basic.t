use Mojo::Base -strict;
use strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('BookScanner');
$t->get_ok('/')->status_is(200)->content_like(qr/IP address/i);

done_testing();
