package Brackets;

=head1 DESCRIPTION

Требуется определить баланс скобок, учитывая их вложенность в строке.
В данном модуле реализованы все необходимые функции, которые нам помогут.

=cut

use Carp qw/ confess /;

=head2 check_brackets

Функция, которая проверяет, что баланс скобок в строке соблюдается.
На вход надо подавать строку, которая состоит из символов:
    '(', ')', '[', ']', '{', '}'

IN:
    $string - строка

OUT:
    die - $string - не строка, которую ожидаем на входе
    0   - баланс скобок не соблюдается
    1   - баланс скобок соблюдается

=cut

sub check_brackets_balance {
    my ( $string ) = @_;

    _validate_data_or_die( $string );

    return 0  if ( length $string ) % 2 != 0;

    my $cleared_string = delete_balanced_brackets_recursively( $string );

    if ( length $cleared_string ) {
        return 0;
    }
    else {
        return 1;
    }
}

=head2 delete_balanced_brackets_recursively

Функция, которая удалит парные скобки, которые идут подряд:
    '[]',
    '{}',
    '()',

IN:
    $string - строка

OUT:
    die - $string - не строка, которую ожидаем на входе

=cut

sub delete_balanced_brackets_recursively {
    my ( $string ) = @_;

    # Разрешаем пустые строки
    _validate_data_or_die( $string, 1 );

    # Пустая строка - базовый вариант рекурсии
    # Если на входе пустая строка, значит, все сбалансированно
    return $string  if $string eq '';

    my $new_string = $string;
    $new_string =~ s/\(\)|\[\]|\{\}//;

    # Строки эквивалентны.
    # Если ничего не было удалено, значит больше парных скобок нет.
    # Базовый случай для выхода из рекурсии.
    if ( $new_string eq $string ) {
        return $new_string;
    }
    else {
        return delete_balanced_brackets_recursively( $new_string );
    }
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
    confess 'wrong sting'      if $data =~ /[^\[\](){}]/;

    return 1;
}

1;
