package BookScanner::Controller::Scan;
# vim: fdm=marker
use Mojo::Base 'Mojolicious::Controller';
use strict;

# GET,POST /scan {{{
sub scan {
	my $self = shift;
	if($self->param('address')) {
		$self->session( 'webcam-address' => $self->param('address') );
		$self->scanner->address( $self->param('address') );
	}
	$self->session( 'project' => 'default-project' ); # TODO get from form
	$self->param( video_feed_uri => $self->scanner->mjpeg_url );
	$self->render();
}
#  }}}
# GET /scan/:project/:image-name {{{
sub project_scan_img {
  my $self = shift;
  my $project = $self->get_param_project;
  my $scan = $project->get_scan($self->param('image-name'));
	$self->render_file(
		filepath => $self->project->filename,
		format => $self->scanner->file_format_name ) if defined $scan;
}
#  }}}
# GET /scans/:project {{{
sub project_scans {
  my $self = shift;
  my $project_name = $self->param('project');
  return $self->render( json => [
    map { $self->scan_to_uri($_) } @{ $self->get_param_project->scans }
  ]);
}
#  }}}
# GET /script/scan.coffee {{{
sub script_scan {
  shift->render( template => 'script/scan', format => 'coffee' );
}
# }}}
# /scan/action/image {{{
# TODO: acquire picture, return JSON with new scan URI
sub action_image {
  my $self = shift;
  my $scan; # TODO acquire
  $self->render( json => { uri => $self->scan_to_uri() } );
}
#  }}}
# Helpers {{{
sub get_param_project {
  my $self = shift;
  $self->scandir->get_project( $self->param('project') ) if $self->param('project');
}

# map to project_scan_img()
sub scan_to_uri {
  my ($self, $scan) = @_;
  my $project_name = $scan->scanproject->name;
  url_for( "/scan/$project_name/@{[file($scan->filename)->basename]}" );
}
# }}}
1;
