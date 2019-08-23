#!/usr/bin/perl

=head1 DESCRIPTION

1.1. Дана строка состоящая из символов '(', ')', '[', ']', '{', '}'.
Требуется определить баланс скобок, учитывая их вложенность:
    '([)]' - не правильно,
    '([])' - правильно.

Решение с рекурсивными регулярными выражениями не принимается.

=cut

use lib::abs '../lib';

use strict;
use warnings;
use Test::Spec;
use Test::Exception;

use StringChecker;

use_ok 'Brackets';

describe 'Brackets::check_brackets_balance' => sub {
    it 'dies' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( sub { die } );

        dies_ok sub { Brackets::delete_balanced_brackets_recursively() };
    };

    it 'returns 0' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );
        Brackets->expects( 'delete_balanced_brackets_recursively' )->returns( '{(})' );

        is
            Brackets::check_brackets_balance( 'unbalanced' ),
            0;
    };

    it 'returns 1' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );
        Brackets->expects( 'delete_balanced_brackets_recursively' )->returns( '' );

        is
            Brackets::check_brackets_balance( 'balanced' ),
            1;
    };
};

describe 'Brackets::delete_balanced_brackets_recursively' => sub {
    it 'dies' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( sub { die } );

        dies_ok sub { Brackets::delete_balanced_brackets_recursively() };
    };

    it 'returns empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );

        is
            Brackets::delete_balanced_brackets_recursively( '' ),
            '';
    };

    it 'returns empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[]' ),
            '';
    };

    it 'returns empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[](){}' ),
            '';
    };

    it 'returns empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[({})](){}' ),
            '';
    };

    it 'returns empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[({})]({{[]}}){}' ),
            '';
    };

    it 'returns empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '([({})]({{[]}}){})' ),
            '';
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[]}' ),
            '}';
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '}' ),
            '}';
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[{]}' ),
            '[{]}';
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[(({[}]))]' ),
            '[(({[}]))]';
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[(({[}]))](){}' ),
            '[(({[}]))]';
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[[]]({)}' ),
            '({)}';
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 )->any_number;

        is
            Brackets::delete_balanced_brackets_recursively( '[[({)}]]({)}' ),
            '[[({)}]]({)}';
    };
};

describe 'Brackets::_validate_data_or_die' => sub {
    it 'dies' => sub {
        StringChecker->expects( '_validate_data_or_die' )->returns( sub { die } );

        dies_ok sub { Brackets::_validate_data_or_die( 'any_invalid_data' ) };
    };

    it 'returns 1' => sub {
        StringChecker->expects( '_validate_data_or_die' )->returns( 1 );

        is
            Brackets::_validate_data_or_die( 'any_valid_data' ),
            1;
    };
};

runtests unless caller;
