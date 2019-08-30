package BinarySearch;

=head1 DESCRIPTION

Модуль двоичного поиска.

=cut

use strict;
use warnings;
use Carp qw/ confess /;

=head2 _check_data

Проверить входящие данные. Это массив?

IN:
    $data - данные, которые проверяем

OUT:
    die - $data - не массив
          $data - пустой массив
    1   - $data - массив

=cut

sub _check_data {
    my ( $data ) = @_;

    confess 'array expected'            unless $data && ref $data eq 'ARRAY';
    confess 'not empty array expected'  unless scalar @$data;

    my $numbers_regexp = qr/^-?\d+(.\d+)?$/;

    foreach my $element ( @$data ) {
        confess 'only numbers expected'  unless $element =~ /$numbers_regexp/;
    }
}

1;
