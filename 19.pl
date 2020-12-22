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

my ($px,$py) = (0,0);
for my $x (0 .. $maxx) {
    $px = $x if $map{"0,$x"} eq '|';
}
my $x = $px;
$y = $py;

my $dx = 0;
my $dy = 1;

my $route = '';

while (1) {
    my $cur = $map{"$y,$x"}||' ';

    if ($cur eq '+') { # turn a corner
        if ($dx) { # now move vertical
            my $ym1 = $y-1;
            $dx = 0;
            $dy = ($map{"$ym1,$x"}||' ') ne ' ' ? -1 : 1;
        } else { # now move horizontal
            my $xm1 = $x-1;
            $dy = 0;
            $dx = ($map{"$y,$xm1"}||' ') ne ' ' ? -1 : 1;
        }
    } elsif ($cur =~ /^[A-Z]$/) { # log a letter
        $route .= $cur;
    } elsif ($cur eq ' ') { # finish
        print "$route\n";
        exit;
    }

    $x += $dx;
    $y += $dy;
}
