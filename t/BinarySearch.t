#!/usr/bin/perl

=head1 DESCRIPTION

Тесты модуля двоичного поиска

=cut

use lib::abs '../lib';

use strict;
use warnings;
use Test::Spec;
use Test::Exception;

use_ok 'BinarySearch';

describe 'BinarySearch::_check_data' => sub {
    before each => sub {
        $@ = undef;
    };

    it 'dies with error "array expected"' => sub {
        dies_ok sub { BinarySearch::_check_data() };
        ok $@ =~ /array expected/;
    };

    it 'dies with error "array expected"' => sub {
        dies_ok sub { BinarySearch::_check_data( '' ) };
        ok $@ =~ /array expected/;
    };

    it 'dies with error "array expected"' => sub {
        dies_ok sub { BinarySearch::_check_data( {} ) };
        ok $@ =~ /array expected/;
    };

    it 'dies with error "not empty array expected"' => sub {
        dies_ok sub { BinarySearch::_check_data( [] ) };
        ok $@ =~ /not empty array expected/;
    };

    it 'dies with error "only numbers expected"' => sub {
        dies_ok sub { BinarySearch::_check_data( [ 1, -2, -7.456, 5, 'asd' ] ) };
        ok $@ =~ /only numbers expected/;
    };
};

runtests unless caller;
