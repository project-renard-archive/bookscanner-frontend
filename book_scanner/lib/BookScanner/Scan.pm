package BookScanner::Scan;
# vim: fdm=marker
use Mojo::Base 'Mojolicious::Controller';
use strict;

# Webcam {{{

sub  webcam_get_address {
	my ($self, $path) = @_;
	my $uri = Mojo::URL->new($self->session('webcam-address'));
	$uri->path($path) if $path;
	$uri;
}

sub webcam_get_mjpg_url { shift->webcam_get_address('/video') }
sub webcam_get_picture_url { shift->webcam_get_address('/photo.jpg') }
sub webcam_get_picture_autofocus_url { shift->webcam_get_address('/photoaf.jpg') }

sub webcam_torchon { my ($self) =@_; $self->ua->get($self->get_webcam_address('/torchon')) }


sub webcam_retrieve_picture {
	my ($self, %options) = @_;
	my $url = $self->webcam_get_picture_url;
	use DDP; p $url;
	$url = $self->webcam_get_picture_autofocus_url() if( $options{autofocus} );
	try {
		$self->ua->get($url)->res->body;
	} catch {
		die "could not get image: $_";
	}
}
# }}}

# Render {{{
sub scan {
	my $self = shift;
	if($self->param('address')) {
		$self->session( 'webcam-address' => $self->param('address') );
	}
	$self->param( video_feed_uri => $self->webcam_get_mjpg_url);
	$self->render();
}
# }}}

1;
