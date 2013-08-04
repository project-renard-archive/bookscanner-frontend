package BookScanner;
use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::RenderFile;
use strict;

# This method will run once at server start
sub startup {
	my $self = shift;

	$self->plugin('RenderFile');
	$self->plugin('Config');
	$self->types->type(coffee => 'text/coffeescript; charset=utf-8');

	# Router
	my $r = $self->routes;

	# Normal route to controller
	$r->get('/')->to('scan#index');
	$r->any('/scan')->to('scan#scan');
}

1;
