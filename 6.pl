#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all sum product uniq);

my $n = 0;

my $line = <>;
chomp $line;

my @in = split /\s+/, $line;

my %seen;

while (1) {
    $n++;

    redistribute();
    last if $seen{join(',',@in)}++;
}

print "$n\n";

sub redistribute {
    my $max = max(@in);

    my $idx = 0;
    for my $i (0..$#in) {
        if ($in[$i] == $max) {
            $idx = $i;
            last;
        }
    }

    $in[$idx] = 0;

    for (1..$max) {
        $idx = ($idx + 1) % @in;
        $in[$idx]++;
    }
}
