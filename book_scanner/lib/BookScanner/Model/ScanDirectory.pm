package BookScanner::Model::ScanDirectory;

use strict;
use warnings;
use Moo;
use List::UtilsBy qw(min_by);
use Path::Class;
use Path::Iterator::Rule;
use BookScanner::Model::ScanProject;

=attr directory

A string for the directory that contains all the scan project directories.

=cut
has directory => ( is => 'rw', required => 1 );

=method project

Returns an arrayref of L<BookScanner::Model::ScanProject> for each subdirectory
in L</directory>.

=cut
sub projects {
	my ($self) = @_;
	return unless $self->directory;
	[ map {
		BookScanner::Model::ScanProject->new(
			name => dir($_)->basename,
			scandir => $self )
	} Path::Iterator::Rule->new
		->min_depth(1)->max_depth(1)
		->dir->all($self->directory) ];
}

=method most_recent_project

Returns the most recently modified L<BookScanner::Model::ScanProject>.

=cut
sub most_recent_project {
	my ($self) = @_;
	min_by { -M $_->directory } @{$self->projects};
}

=method get_project($name)

Returns a project by name. If the project name does not already exist, it will
create a new project.

=cut
sub get_project {
	my ($self, $name) = @_;

	BookScanner::Model::ScanProject->new( scandir => $self, name => $name );
}


1;
