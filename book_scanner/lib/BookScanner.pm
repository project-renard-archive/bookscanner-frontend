package BookScanner;
use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::RenderFile;
use strict;

use BookScanner::Model::ScanDirectory;
use BookScanner::Model::Scanner::IPWebcam;

# This method will run once at server start
sub startup {
	my $self = shift;

	$self->plugin('RenderFile');
	$self->plugin('Config');
	$self->types->type(coffee => 'text/coffeescript; charset=utf-8');

	$self->helper( scanner => sub {
		state $scanner = BookScanner::Model::Scanner::IPWebcam->new();
	});

	my $scan_directory = $self->config->{scan_directory};
	$self->helper( scandir  => sub {
		state $scandir = BookScanner::Model::ScanDirectory->new( directory => $scan_directory );
	});

	# Router
	my $r = $self->routes;

	$r->namespaces(['BookScanner::Controller']);

	# Normal route to controller
	$r->get('/')->to('scan#index');
	$r->post('/scan')->to('scan#scan');
	$r->any('/scan/:project')->to('scan#scan_project');

	$r->get('/scan/:project/:image-name')->to('scan#project_scan_img');
	$r->get('/scans/:project')->to('scan#project_scans');
	$r->get('/scan/:project/action/scan')->to('scan#project_action_scan');

	$r->get('/scan/:project/script/setup.coffee')->to('scan#script_setup');
}

1;
