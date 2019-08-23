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

describe 'Brackets::check_brackets_balance' => sub {
    it 'dies' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( sub { die } );
        dies_ok sub { Brackets::delete_balanced_brackets_recursively() };
    };

    it 'returns 0' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );

        is
            Brackets::check_brackets_balance( '(' ),
            0;
    };

    it 'returns 0' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );

        is
            Brackets::check_brackets_balance( '(){}]' ),
            0;
    };

    it 'returns 0' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );

        is
            Brackets::check_brackets_balance( '({)}' ),
            0;
    };

    it 'returns 0' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );

        is
            Brackets::check_brackets_balance( '{([)}]' ),
            0;
    };

    it 'returns 0' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );

        is
            Brackets::check_brackets_balance( '{}[(]())' ),
            0;
    };
};

describe 'Brackets::delete_balanced_brackets_recursively' => sub {
    it 'dies' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( sub { die } );
        dies_ok sub { Brackets::delete_balanced_brackets_recursively() };
    };

    it 'returns not empty string' => sub {
        Brackets->expects( '_validate_data_or_die' )->returns( 1 );
        is
            Brackets::delete_balanced_brackets_recursively( '[{]}' ),
            '[{]}';
    };
};

describe 'Brackets::_validate_data_or_die' => sub {
    before each => sub {
        $@ = undef;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { Brackets::_validate_data_or_die() };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { Brackets::_validate_data_or_die( [] ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { Brackets::_validate_data_or_die( {} ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { Brackets::_validate_data_or_die( '' ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "wrong sting"' => sub {
        dies_ok sub { Brackets::_validate_data_or_die( '[abc]' ) };
        ok $@ =~ /wrong sting/;
    };

    it 'returns 1' => sub {
        is
            Brackets::_validate_data_or_die( '[]' ),
            1;
    };

    it 'returns 1' => sub {
        is
            Brackets::_validate_data_or_die( '[()[]{]' ),
            1;
    };
};

runtests unless caller;
