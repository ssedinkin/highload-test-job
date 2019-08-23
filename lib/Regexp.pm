package Regexp;

=head1 DESCRIPTION

Удалить одним регекспом из предложения, все слова содержащие повторяющиеся символы.

=cut

use lib::abs '../lib';

use strict;
use warnings;

use StringChecker;

=head2 delete_words_by_regexp

Функция, которая удалит одним регекспом из предложения, все слова содержащие повторяющиеся символы.

IN:
    $string - строка

OUT:
    die         - $string - не строка, которую ожидаем на входе
    $new_string - новая строка

=cut

sub delete_words_by_regexp {
    my ( $string ) = @_;

    StringChecker::validate_data( 0, 'regexp', $string );

    my $new_string = $string;

    $new_string =~ s/\b(\w)\w*\1\w*//g;

    return $new_string;
}

1;
