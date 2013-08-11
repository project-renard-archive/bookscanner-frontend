package BookScanner::Model::Scan;

use strict;
use warnings;
use DateTime;
use DateTime::Format::W3CDTF;
use Moo;
use Path::Class;
use File::Slurp qw(write_file read_file);
use File::Touch;

=attr scanproject

The L<BookScanner::Model::ScanProject> for this scan. Required.

=cut 
has scanproject => ( is => 'rw', weak_ref => 1, required => 1 );

=attr creation_time

A L<DateTime> of when the scan was created.

=cut
has creation_time => ( is => 'lazy' );

sub _build_creation_time {
	my $self = shift;
	if($self->has_filename) {
		my $dt_str = (file($self->filename)->basename =~ /^(.*)[._]/)[0];
		return $self->_dt_format->parse_datetime($dt_str);
	}
	DateTime->now;
}

has _dt_format => ( is => 'ro', default => sub { DateTime::Format::W3CDTF->new() } );

=attr filename

A string for the filename of the scanned image.

=cut
has filename => ( is => 'rw', builder => 1, lazy => 1, predicate => 1 );

# build filename if not already in storage
sub _build_filename {
	my $self = shift;
	my $fname_base = $self->_dt_format->format_datetime($self->creation_time);
	my $dir = dir($self->scanproject->directory);
	my $ext = $self->scanproject->extension;
	my $file = $dir->file( $fname_base . $ext );
	if( -e $file ) {
		my $suffix = "0000"; # add suffix if there is a conflict
		while( -e $file ) {
			$file = $dir->file( $fname_base . "_$suffix" . $ext );
			$suffix++;
		}
	}
	my $count = File::Touch->new->touch($file);
	$file;
}

sub BUILD {
	my $self = shift;
	$self->filename; # call builder if does not exist
}

=method write($image)

Writes the contents of $image to the scan file.

=cut
sub write {
	my ($self, $image) = @_;
	write_file( $self->filename, $image );
}

=method read

Returns the contents of the scanned image.

=cut 
sub read {
	my $self = shift;
	read_file( $self->filename );
}

1;
