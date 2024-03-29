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

describe 'BinarySearch::_check_array' => sub {
    before each => sub {
        $@ = undef;
    };

    it 'dies with error "array expected"' => sub {
        dies_ok sub { BinarySearch::_check_array() };
        ok $@ =~ /array expected/;
    };

    it 'dies with error "array expected"' => sub {
        dies_ok sub { BinarySearch::_check_array( '' ) };
        ok $@ =~ /array expected/;
    };

    it 'dies with error "array expected"' => sub {
        dies_ok sub { BinarySearch::_check_array( {} ) };
        ok $@ =~ /array expected/;
    };

    it 'dies with error "not empty array expected"' => sub {
        dies_ok sub { BinarySearch::_check_array( [] ) };
        ok $@ =~ /not empty array expected/;
    };

    it 'dies with error "only numbers expected"' => sub {
        dies_ok sub { BinarySearch::_check_array( [ 1, -2, -7.456, 5, 'asd' ] ) };
        ok $@ =~ /only numbers expected/;
    };

    it 'dies with error "sorted array expected"' => sub {
        dies_ok sub { BinarySearch::_check_array( [ 1, -2, -7.456, 5 ] ) };
        ok $@ =~ /sorted array expected/;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_array( [ 1234 ] ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_array( [ 0, 0 ] ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_array( [ -0.5, 0, 0.6, 78 ] ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_array( [ -555, -0.5, 0, 0.6, 78, 142.55 ] ),
            1;
    };
};

describe 'BinarySearch::_check_element' => sub {
    before each => sub {
        $@ = undef;
    };

    it 'dies with error "element must be number"' => sub {
        dies_ok sub { BinarySearch::_check_element() };
        ok $@ =~ /element must be number/;
    };

    it 'dies with error "element must be number"' => sub {
        dies_ok sub { BinarySearch::_check_element( {} ) };
        ok $@ =~ /element must be number/;
    };

    it 'dies with error "element must be number"' => sub {
        dies_ok sub { BinarySearch::_check_element( [] ) };
        ok $@ =~ /element must be number/;
    };

    it 'dies with error "element must be number"' => sub {
        dies_ok sub { BinarySearch::_check_element( '' ) };
        ok $@ =~ /element must be number/;
    };

    it 'dies with error "element must be number"' => sub {
        dies_ok sub { BinarySearch::_check_element( 'abc' ) };
        ok $@ =~ /element must be number/;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_element( 123 ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_element( -123 ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_element( 0 ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_element( -123.566 ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_element( 123.666 ),
            1;
    };
};

describe 'BinarySearch::_check_eq_elements' => sub {
    it 'returns 0' => sub {
        is
            BinarySearch::_check_eq_elements( 0, -0.5 ),
            0;
    };

    it 'returns 0' => sub {
        is
            BinarySearch::_check_eq_elements( 0, 1 ),
            0;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_eq_elements( 123.666, 123.666 ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_eq_elements( -123.666, -123.666 ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_eq_elements( 0, 0 ),
            1;
    };

    it 'returns 1' => sub {
        is
            BinarySearch::_check_eq_elements( 1, 1 ),
            1;
    };
};

describe 'BinarySearch::_get_median_value_and_number' => sub {
    it 'returns expected value and position' => sub {
        is_deeply
            [ BinarySearch::_get_median_value_and_position( [ 123, 456 ] ) ],
            [ 456, 1 ];
    };

    it 'returns expected value and position' => sub {
        is_deeply
            [ BinarySearch::_get_median_value_and_position( [ 123, 456, 777 ] ) ],
            [ 456, 1 ];
    };

    it 'returns expected value and position' => sub {
        is_deeply
            [ BinarySearch::_get_median_value_and_position( [ 123, 456, 777, 778 ] ) ],
            [ 777, 2 ];
    };

    it 'returns expected value and position' => sub {
        is_deeply
            [ BinarySearch::_get_median_value_and_position( [ 123, 456, 777, 778, 999 ] ) ],
            [ 777, 2 ];
    };
};

describe 'BinarySearch::search' => sub {
    it 'dies' => sub {
        BinarySearch->expects( '_check_array' )->returns( sub { die } );
        BinarySearch->expects( '_check_element' )->never;
        dies_ok sub { BinarySearch::search() };
    };

    it 'dies' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 );
        BinarySearch->expects( '_check_element' )->returns( sub { die } );
        dies_ok sub { BinarySearch::search() };
    };

    it 'returns 1' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 1, [ 1 ] ),
            1;
    };

    it 'returns 1' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 1, [ 1, 5 ] ),
            1;
    };

    it 'returns 1' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 5, [ 1, 5, 88 ] ),
            1;
    };

    it 'returns 1' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 1, [ 1, 5, 7, 77, 87, 123, 355, 56777 ] ),
            1;
    };

    it 'returns 1' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 56777, [ 1, 5, 7, 77, 87, 123, 355, 56777 ] ),
            1;
    };

    it 'returns 0' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 1, [ 5 ] ),
            0;
    };

    it 'returns 0' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 1, [ 0, 5 ] ),
            0;
    };

    it 'returns 0' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 0, [ 1, 5, 7, 77, 87, 123, 355, 56777 ] ),
            0;
    };

    it 'returns 0' => sub {
        BinarySearch->expects( '_check_array' )->returns( 1 )->any_number;
        BinarySearch->expects( '_check_element' )->returns( 1 )->any_number;
        is
            BinarySearch::search( 555, [ 1, 5, 7, 77, 87, 123, 355, 56777 ] ),
            0;
    };
};

runtests unless caller;
