package StringChecker;

=head1 DESCRIPTION

Модуль StringChecker.
В нем находится метод для валидации входных данных.

=cut

use strict;
use warnings;
use Carp qw/ confess /;

=head2 validate_data

Проверить входящие данные. Строка ли это?
Пустая строка - строка.
Непустая строка - строка.
Массивы, хэши, undef и прочая фигня - не строка

IN:
    $allow_empty - пустая строка разрешена

OUT:
    die - $allow_empty невалидный

=cut

sub validate_data {
    my ( $allow_empty ) = @_;

    confess 'allow_empty parameter invalid'  unless _is_not_empty_string( $allow_empty );
}

=head2 _is_string

Проверить входящие данные. Строка ли это?
Пустая строка - строка.
Непустая строка - строка.
Массивы, хэши, undef и прочая фигня - не строка

IN:
    $data - входящие данные

OUT:
    0 - не строка
    1 - строка

=cut

sub _is_string {
    my ( $data ) = @_;

    return 0  unless defined $data;
    return 0  if ref $data;

    return 1;
}

=head2 _is_not_empty_string

Проверить входящие данные. Это непустая?
Пустая строка - не строка.
Непустая строка - строка.
Массивы, хэши, undef и прочая фигня - не строка

IN:
    $data - входящие данные

OUT:
    0 - не строка
    1 - строка

=cut

sub _is_not_empty_string {
    my ( $data ) = @_;

    return 0  unless _is_string( $data );
    return 0  unless length $data;

    return 1;
}

=head2 _validate_data_or_die

Валидация входных данных. На входе мы ждем строку, которая состоит из символов:
    '(', ')', '[', ']', '{', '}'
Если это не так, упадет.

IN:
    $data               - входящие данные
    $allow_empty_string - разрешить пустую строку

OUT:
    die - $string - не строка, которую ожидаем на входе
    1   - строка валидная

=cut

sub _validate_data_or_die {
    my ( $data, $allow_empty_string ) = @_;

    confess 'string expected'  if ref $data || !length $data && !$allow_empty_string;
    confess 'wrong string'     if $data =~ /[^\[\](){}]/;

    return 1;
}

1;
