package BookScanner::Model::ScanDirectory;

use strict;
use warnings;
use Moo;
use List::UtilsBy qw(min_by);
use Path::Class;
use Path::Iterator::Rule;

=attr directory

A string for the directory that contains all the scan project directories.

=cut
has directory => ( is => 'rw', required => 1 );

=attr project

Returns an arrayref of L<BookScanner::Model::ScanProject> for each subdirectory in L</directory>.

=cut
has projects => ( is => 'rw', lazy => 1, builder => 1);

=attr most_recent_project

Returns the most recently modified L<BookScanner::Model::ScanProject>.

=cut
has most_recent_project => ( is => 'rw', lazy => 1, builder => 1 );

sub _build_projects {
  my ($self) = @_;
  return unless $self->directory;
  map {
    BookScanner::Model::ScanDirectory->new( directory => $_ )
  } Path::Iterator::Rule->new
		->min_depth(1)->max_depth(1)
                ->dir->all($self->directory);
}

sub _build_most_recent_project {
  my ($self) = @_;
  min_by { -M $_->directory } $self->projects;
}

# TODO
sub new_project {
  BookScanner::Model::ScanDirectory->new( directory => );
}


1;
