package StringChecker;

=head1 DESCRIPTION

Модуль StringChecker.
В нем находится метод для валидации входных данных.

=cut

use Carp qw/ confess /;

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
