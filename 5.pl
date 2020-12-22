#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product all any uniq);

my $n = 0;

my @mem;

while (<>) {
    chomp;

    push @mem, $_;
}

my $pc = 0;

while ($pc >= 0 && $pc < @mem) {
    $n++;
    my $newpc = $pc + $mem[$pc];
    $mem[$pc]++;
    $pc = $newpc;
}

print "$n\n";
