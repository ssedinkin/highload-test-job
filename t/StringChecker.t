#!/usr/bin/perl

=head1 DESCRIPTION

Тесты модуля StringChecker

=cut

use lib::abs '../lib';

use Test::Spec;
use Test::Exception;

use_ok 'StringChecker';

runtests unless caller;
