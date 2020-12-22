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

my %map;

$map{"0,0"} = 1;

while (1) {
    $x += $dx[$dir];
    $y += $dy[$dir];

    $dir = ($dir+1)%4 if $x > $maxx || $y > $maxy || $x < $minx || $y < $miny;

    $minx = $x if $x < $minx;
    $miny = $y if $y < $miny;

    $maxx = $x if $x > $maxx;
    $maxy = $y if $y > $maxy;

    $map{"$y,$x"} = sum_adjacent($x,$y);
    if ($map{"$y,$x"} > $input) {
        print $map{"$y,$x"},"\n";
        exit;
    }
}

sub sum_adjacent {
    my ($x, $y) = @_;

    my $s = 0;

    for my $dy (-1..1) {
        for my $dx (-1..1) {
            next if $dx==0 && $dy==0;
            my $px = $x+$dx;
            my $py = $y+$dy;
            $s += $map{"$py,$px"} if exists $map{"$py,$px"};
        }
    }

    return $s;
}
