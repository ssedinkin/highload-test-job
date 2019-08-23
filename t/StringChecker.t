#!/usr/bin/perl

=head1 DESCRIPTION

Тесты модуля StringChecker

=cut

use lib::abs '../lib';

use strict;
use warnings;
use Test::Spec;
use Test::Exception;

use_ok 'StringChecker';

describe 'StringChecker::_is_string' => sub {
    it 'returns 0' => sub {
        is
           StringChecker::_is_string(),
           0;
    };

    it 'returns 0' => sub {
        is
           StringChecker::_is_string( [] ),
           0;
    };

    it 'returns 0' => sub {
        is
           StringChecker::_is_string( {} ),
           0;
    };

    it 'returns 1' => sub {
        is
           StringChecker::_is_string( '' ),
           1;
    };

    it 'returns 1' => sub {
        is
           StringChecker::_is_string( 'abcd' ),
           1;
    };

    it 'returns 1' => sub {
        is
           StringChecker::_is_string( '[abcd]' ),
           1;
    };

    it 'returns 1' => sub {
        is
           StringChecker::_is_string( '{ abcd => "abcd" }' ),
           1;
    };
};

describe 'StringChecker::_is_not_empty_string' => sub {
    it 'returns 0' => sub {
        StringChecker->expects( '_is_string' )->returns( 0 );

        is
           StringChecker::_is_not_empty_string( 'not_string' ),
           0;
    };

    it 'returns 0' => sub {
        StringChecker->expects( '_is_string' )->returns( 1 );
 
        is
           StringChecker::_is_not_empty_string( '' ),
           0;
    };

    it 'returns 1' => sub {
        StringChecker->expects( '_is_string' )->returns( 1 );

        is
           StringChecker::_is_not_empty_string( 'not_empty_string' ),
           1;
    };
};

describe 'StringChecker::_validate_brackets_data' => sub {
    before each => sub {
        $@ = undef;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_brackets_data() };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_brackets_data( [] ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_brackets_data( {} ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_brackets_data( '' ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "wrong string"' => sub {
        dies_ok sub { StringChecker::_validate_brackets_data( '[abc]' ) };
        ok $@ =~ /wrong string/;
    };

    it 'returns 1' => sub {
        my $allow_empty_string = 1;

        is
            StringChecker::_validate_brackets_data( '', $allow_empty_string ),
            1;
    };

    it 'returns 1' => sub {
        is
            StringChecker::_validate_brackets_data( '[]' ),
            1;
    };

    it 'returns 1' => sub {
        is
            StringChecker::_validate_brackets_data( '[()[]{]' ),
            1;
    };
};

describe 'StringChecker::validate_data' => sub {
    before each => sub {
        $@ = undef;
    };

    it 'dies with error "allow_empty parameter invalid"' => sub {
        dies_ok sub { StringChecker::validate_data() };
        ok $@ =~ /allow_empty parameter invalid/;
    };

    it 'dies with error "task_name parameter invalid"' => sub {
        dies_ok sub { StringChecker::validate_data( 0 ) };
        ok $@ =~ /task_name parameter invalid/;
    };

    it 'dies with error "task_name parameter invalid"' => sub {
        dies_ok sub { StringChecker::validate_data( 0, 'bad name' ) };
        ok $@ =~ /task_name parameter invalid/;
    };

    it 'dies with error "task_name parameter invalid"' => sub {
        StringChecker->expects( 'validate_data' )->returns( sub { die } );

        dies_ok sub { StringChecker::validate_data( 0, 'brackets' ) };
    };

    it 'returns 1' => sub {
        StringChecker->expects( 'validate_data' )->returns( 1 );

        is
            StringChecker::validate_data( 0, 'brackets', 'any_valid_data' ),
            1;
    };
};

runtests unless caller;
