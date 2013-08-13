package BookScanner::Controller::Scan;
# vim: fdm=marker
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON 'j';
use strict;
use Try::Tiny;
use Path::Class;

# POST /scan {{{
sub scan {
	my $self = shift;
	if($self->param('address')) {
		$self->session( 'webcam-address' => $self->param('address') );
		$self->scanner->address( $self->param('address') );
		$self->redirect_to( '/scan/'. $self->param('project') );
	}
}
#  }}}
# GET /scan/:project {{{
sub scan_project {
	my $self = shift;
	return $self->redirect_to('/') unless $self->scanner->address;
	$self->param( video_feed_uri => $self->scanner->mjpeg_url );
  $self->param( app_config => j({
    project => $self->param('project'),
    url => $self->url_for( '/scans/' . $self->param('project') ),
  }) ); # JSON
  $self->param( projectview_config => j({
    scan_url => $self->url_for( '/scan/' . $self->param('project') . '/action/scan' ),
  }) ); # JSON
	$self->render();
}
# }}}
# GET /scan/:project/:image_name {{{
sub project_scan_img {
	my $self = shift;
	my $project = $self->get_param_project;
	my $scan = $project->get_scan($self->param('image_name') . '.' . $self->stash('format'));
	$self->render_file(
		filepath => $scan->filename->absolute,
		format => $self->scanner->file_format_name ) if defined $scan;
}
#  }}}
# GET /scans/:project {{{
sub project_scans {
	my $self = shift;
	return $self->render( json => [
		map { $self->scan_ToJSON($_) } @{ $self->get_param_project->scans }
	]);
}
#  }}}
# GET /scan/:project/action/scan {{{
# acquire picture, return JSON with new scan URI
sub project_action_scan {
	my $self = shift;
	my $scan = $self->get_scan;
  $self->render( json => $self->scan_ToJSON($scan) );
}
#  }}}
# Helpers {{{
sub get_scan {
  my ($self) = @_;
  my $project = $self->get_param_project;
  my $url = $self->scanner->picture_url;
  return unless defined $project and $url;
  my $image;
	try {
		$image = $self->ua->get($url)->res->body;
	} catch {
		die "could not get image: $_";
	};
  my $scan = $project->new_scan;
  $scan->write( $image );
  $scan;
}

sub get_param_project {
	my $self = shift;
	$self->scandir->get_project( $self->param('project') ) if $self->param('project');
}

sub scan_ToJSON {
	my ($self, $scan) = @_;
  { 'scan-image' => $self->scan_to_uri($scan) };
}
# map to project_scan_img()
sub scan_to_uri {
	my ($self, $scan) = @_;
	my $project_name = $scan->scanproject->name;
	$self->url_for( "/scan/$project_name/@{[file($scan->filename)->basename]}" );
}
# }}}
1;
