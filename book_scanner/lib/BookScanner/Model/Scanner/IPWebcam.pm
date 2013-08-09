package BookScanner::Model::Scanner::IPWebcam;

use strict;
use warnings;
use Moo;
use Mojo::URL;
with 'BookScanner::Model::Scanner';

sub  _webcam_get_address {
	my ($self, $path) = @_;
	my $uri = Mojo::URL->new($self->address);
	$uri->path($path) if $path;
	$uri;
}

has address => ( is => 'rw' );

has autofocus => ( is => 'rw', default => sub { 1 } );

has picture_url => ( is => 'lazy' );

sub _build_picture_url {
  my $self = shift;
  $self->_webcam_get_address( $self->autofocus ? '/photoaf.jpg' : '/photo.jpg' );
}

has mjpeg_url => ( is => 'lazy' );

sub _build_mjpeg_url {
  shift->_webcam_get_address('/video');
}

has file_format_extension => ( is => 'ro', default => sub { '.jpg' });
has file_format_name => ( is => 'ro', default => sub { 'jpg' });


#sub webcam_torchon { my ($self) =@_; $self->ua->get($self->get_webcam_address('/torchon')) }


1;
