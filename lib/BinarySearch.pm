package BinarySearch;

=head1 DESCRIPTION

Модуль двоичного поиска.

=cut

use strict;
use warnings;
use Carp qw/ confess /;
use Data::Compare;

=head2 search

Метод поиска элемента в массиве.
На вход надо передать отсортированный массив и элемент, который надо найти.
Если не передать, метод упадет.

IN:
    $element - какой элемент ищем в массиве
    $array   - отсортированный массив

OUT:
    die - входные данные не верны
    1   - элемент найден
    0   - элемент не найден

=cut

sub search {
    my ( $element, $array ) = @_;

    _check_data( $array );
}

=head2 _check_data

Проверить входящие данные. Это массив?

IN:
    $data - данные, которые проверяем

OUT:
    die - $data - не массив
          $data - пустой массив
          $data - неотсортированный массив
    1   - $data - на входе отсортированный массив

=cut

sub _check_data {
    my ( $data ) = @_;

    confess 'array expected'            unless $data && ref $data eq 'ARRAY';
    confess 'not empty array expected'  unless scalar @$data;

    my $numbers_regexp = qr/^-?\d+(.\d+)?$/;

    foreach my $element ( @$data ) {
        confess 'only numbers expected'  unless $element =~ /$numbers_regexp/;
    }

    my @sorted_numbers = sort { $a <=> $b } @$data;

    confess 'sorted array expected'  unless Compare( $data, \@sorted_numbers );

    return 1;
}

1;
