#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my %edge;

while (<>) {
    chomp;

    if (/^(\d+) <-> ([0-9, ]+)$/) {
        my ($a,$bs) = ($1, $2);
        my @bs = split /, /, $bs;
        $edge{$a}{$_} = 1 for @bs;
        $edge{$_}{$a} = 1 for @bs;
    } else {
        print "bad: $_\n";
    }
}

my %visited;

my $count = 0;

for my $k (keys %edge) {
    if (!$visited{$k}) {
        dfs($k);
        $count++;
    }
}

print "$count\n";

sub dfs {
    my ($n) = @_;

    return if $visited{$n};
    $visited{$n} = 1;

    for my $neighbour (keys %{ $edge{$n} }) {
        dfs($neighbour);
    }
}
