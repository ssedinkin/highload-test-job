#!/usr/bin/perl

=head1 DESCRIPTION

Удалить одним регекспом из предложения, все слова содержащие повторяющиеся символы.

=cut

use lib::abs '../lib';

use strict;
use warnings;
use Test::Spec;
use Test::Exception;

use_ok 'Regexp';

runtests unless caller;
