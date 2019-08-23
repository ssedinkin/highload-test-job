#!/usr/bin/perl

=head1 DESCRIPTION

1.1. Дана строка состоящая из символов '(', ')', '[', ']', '{', '}'.
Требуется определить баланс скобок, учитывая их вложенность:
    '([)]' - не правильно,
    '([])' - правильно.

Решение с рекурсивными регулярными выражениями не принимается.

=cut

use lib::abs '../lib';

use Test::Spec;
use Test::Exception;

use_ok 'Brackets';

runtests unless caller;
