package BookScanner::Model::ScanProject;

use strict;
use warnings;
use Moo;
use Path::Class;
use Path::Iterator::Rule;
use BookScanner::Model::Scan;

has name => ( is => 'rw', required => 1 );

has scandir => ( is => 'ro', weak_ref => 1 );

has directory => ( is => 'rw', builder => 1, lazy => 1 );

has extension => ( is => 'rw', default => sub { '.jpg' });

sub _build_directory {
	my ($self) = @_;
	dir($self->scandir->directory)->subdir($self->name) if $self->scandir;
}

sub BUILD {
	my ($self) = @_;
	# make the directory if it doesn't exist
	dir( $self->directory )->mkpath unless -d $self->directory;
}

=method scans

Returns an arrayref of L<BookScanner::Model::Scan> 

=cut
sub scans {
	my $self = shift;
	[ sort { $a->filename cmp $b->filename } map {
		BookScanner::Model::Scan->new( filename => file($_), scanproject => $self )
	} Path::Iterator::Rule->new
		->min_depth(0)->max_depth(2)
		->file->all($self->directory) ];
}

=method new_scan 

Returns a new L<BookScanner::Model::Scan>.

=cut
sub new_scan {
	my $self = shift;
	BookScanner::Model::Scan->new( scanproject => $self );
}

=method get_scan($image_name)

retrieves the scan with the image name

=cut
sub get_scan {
  my ($self, $fname) = @_;
  BookScanner::Model::Scan->new( filename => dir($self->directory)->file($fname)->absolute,
    scanproject => $self );
}


1;
