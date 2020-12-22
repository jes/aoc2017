#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

my $l = <>;
chomp $l;

# cube coordinates: https://www.redblobgames.com/grids/hexagons/
my ($x,$y,$z) = (0,0,0);

my $max = 0;

for my $dir (split /,/, $l) {
    if ($dir eq 'n') {
        $x += 1; $y -= 1;
    } elsif ($dir eq 's') {
        $x -= 1; $y += 1;
    } elsif ($dir eq 'nw') {
        $y += 1; $z -= 1;
    } elsif ($dir eq 'se') {
        $y -= 1; $z += 1;
    } elsif ($dir eq 'ne') {
        $z += 1; $x -= 1;
    } elsif ($dir eq 'sw') {
        $z -= 1; $x += 1;
    }

    my $d = (abs($x)+abs($y)+abs($z)) /2;
    $max = $d if $d > $max;
}

print "$max\n";
