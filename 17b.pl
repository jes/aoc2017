#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

my $input = 380;

my @buffer = (0);
my $ptr = 0;

my $answer = 0;

for my $insert (1 .. 50_000_000) {
    $ptr = ($ptr + $input) % $insert;
    $answer = $insert if $ptr == 0;
    $ptr++;
}

print "$answer\n";
