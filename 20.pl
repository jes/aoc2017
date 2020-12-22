#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my @particles;

my $pid = 0;

while (<>) {
    chomp;

    if (/^p=<([0-9-,]+)>, v=<([0-9-,]+)>, a=<([0-9-,]+)>$/) {
        my ($p, $v, $a) = ($1, $2, $3);

        push @particles, {
            id => $pid++,
            p => [split /,/,$p],
            v => [split /,/,$v],
            a => [split /,/,$a],
        }
    } else {
        print "bad: $_\n";
    }
}

my $oldclosestid = -1;
while (1) {
    my $closestid = -1;
    my $closestdist = 1000000;
    for my $p (@particles) {
        $p->{v}[$_] += $p->{a}[$_] for (0..2);
        $p->{p}[$_] += $p->{v}[$_] for (0..2);

        my $d = sum(map { abs($_) } @{ $p->{p} });
        if ($d < $closestdist) {
            $closestdist = $d;
            $closestid = $p->{id};
        }
    }

    if ($closestid != $oldclosestid) {
        print "$closestid\n";
        $oldclosestid = $closestid;
    }
}
