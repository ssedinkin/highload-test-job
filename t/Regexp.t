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
};

runtests unless caller;
