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

    confess 'string expected'  if ( ref $string || !length $string );
    confess 'wrong sting'      if $string =~ /[^\[\](){}]/;

    return 0  if ( length $string ) % 2 != 0;
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

    confess 'string expected'  if ( ref $string || !length $string );
    confess 'wrong sting'      if $string =~ /[^\[\](){}]/;
}

1;
