#!/usr/bin/perl

use strict;
use warnings;

my $input = 368078;

my @dx = (1,0,-1,0);
my @dy = (0,1,0,-1);

my $dir = 0;
my ($x,$y) = (0, 0);
my $n = 1;

my ($minx,$maxx,$miny,$maxy) = (0,0,0,0);

while ($n < $input) {
    $x += $dx[$dir];
    $y += $dy[$dir];

    $dir = ($dir+1)%4 if $x > $maxx || $y > $maxy || $x < $minx || $y < $miny;

    $minx = $x if $x < $minx;
    $miny = $y if $y < $miny;

    $maxx = $x if $x > $maxx;
    $maxy = $y if $y > $maxy;

    $n++;
}

my $d = abs($x) + abs($y);

print "$d\n";
