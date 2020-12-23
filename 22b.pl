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

for (1..10_000_000) {
    $map{"$y,$x"} ||= '.';

    my $c = $map{"$y,$x"};
    if ($c eq '.') {
        ($dx,$dy) = ($dy,-$dx);
        $map{"$y,$x"} = 'w';
    } elsif ($c eq 'w') {
        $map{"$y,$x"} = '#';
        $infected++;
    } elsif ($c eq '#') {
        ($dx,$dy) = (-$dy,$dx);
        $map{"$y,$x"} = 'f';
    } elsif ($c eq 'f') {
        $map{"$y,$x"} = '.';
        ($dx,$dy) = (-$dx,-$dy);
    }
    
    $x += $dx;
    $y += $dy;
}

print "$infected\n";
