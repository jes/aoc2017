#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product all any uniq);

my $n = 0;

my ($maxx,$maxy);
my %map;

my $y = 0;
while (<>) {
    chomp;

    my @c = split //;

    for my $x (0..$#c) {
        $map{"$y,$x"} = $c[$x];
        $maxx = $x;
    }
    $maxy = $y;
    $y++;
}

my $x = $maxx/2;
$y = $maxy/2;

my $dx = 0;
my $dy = -1;

my $infected = 0;

for (1..10000) {
    $map{"$y,$x"} ||= '';

    if ($map{"$y,$x"} eq '#') {
        ($dx,$dy) = (-$dy,$dx);
        $map{"$y,$x"} = '.';
    } else {
        ($dx,$dy) = ($dy,-$dx);
        $map{"$y,$x"} = '#';
        $infected++;
    }
    $x += $dx;
    $y += $dy;
}

print "$infected\n";
