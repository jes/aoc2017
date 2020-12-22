#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

my $input = 380;

my @buffer = (0);
my $ptr = 0;

for my $insert (1 .. 2017) {
    $ptr = ($ptr + $input) % @buffer;
    @buffer = (@buffer[0..$ptr-1], $insert, @buffer[$ptr..$#buffer]);
    $ptr++;
}

print $buffer[$ptr], "\n";
