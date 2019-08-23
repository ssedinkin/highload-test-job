#!/usr/bin/perl

=head1 DESCRIPTION

Тесты модуля StringChecker

=cut

use lib::abs '../lib';

use Test::Spec;
use Test::Exception;

use_ok 'StringChecker';

describe 'StringChecker::_validate_data_or_die' => sub {
    before each => sub {
        $@ = undef;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_data_or_die() };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_data_or_die( [] ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_data_or_die( {} ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "string expected"' => sub {
        dies_ok sub { StringChecker::_validate_data_or_die( '' ) };
        ok $@ =~ /string expected/;
    };

    it 'dies with error "wrong sting"' => sub {
        dies_ok sub { StringChecker::_validate_data_or_die( '[abc]' ) };
        ok $@ =~ /wrong sting/;
    };

    it 'returns 1' => sub {
        my $allow_empty_string = 1;

        is
            StringChecker::_validate_data_or_die( '', $allow_empty_string ),
            1;
    };

    it 'returns 1' => sub {
        is
            StringChecker::_validate_data_or_die( '[]' ),
            1;
    };

    it 'returns 1' => sub {
        is
            StringChecker::_validate_data_or_die( '[()[]{]' ),
            1;
    };
};

runtests unless caller;
