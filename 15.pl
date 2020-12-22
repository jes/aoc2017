#!/usr/bin/perl

use strict;
use warnings;

my $gena = 783;
my $genb = 325;

my $n = 0;

for (1..40_000_000) {
    $gena = ($gena * 16807) % 2147483647;
    $genb = ($genb * 48271) % 2147483647;
    $n++ if ($gena&0xffff) == ($genb&0xffff);
}

print "$n\n";
