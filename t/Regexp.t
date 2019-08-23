#!/usr/bin/perl

=head1 DESCRIPTION

Удалить одним регекспом из предложения, все слова содержащие повторяющиеся символы.

=cut

use lib::abs '../lib';

use strict;
use warnings;
use Test::Spec;
use Test::Exception;

use StringChecker;

use_ok 'Regexp';

describe 'Regexp::delete_words_by_regexp' => sub {
    it 'dies' => sub {
        StringChecker->expects( 'validate_data' )->returns( sub { die } );

        dies_ok sub { Regexp::delete_words_by_regexp( 'any_invalid_data' ) };
    };

    it 'returns as is' => sub {
        is
           Regexp::delete_words_by_regexp( 'ret string as is' ),
           'ret string as is';
    };

    it 'returns new string' => sub {
        is
           Regexp::delete_words_by_regexp( 'returns new string' ),
           ' new string';
    };

    it 'returns new string' => sub {
        is
           Regexp::delete_words_by_regexp( 'www' ),
           '';
    };

    it 'returns new string' => sub {
        is
           Regexp::delete_words_by_regexp( 'parrot' ),
           '';
    };
};

runtests unless caller;
