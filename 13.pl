#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my %firewall;
my %scanner;
my %scannerdir;

while (<>) {
    chomp;

    if (/^(\d+): (\d+)$/) {
        my ($depth, $range) = ($1, $2);
        $firewall{$depth} = $range;
        $scanner{$depth} = 0;
        $scannerdir{$depth} = 1;
    } else {
        print "bad: $_\n";
    }
}

my $maxdepth = max(keys %firewall);
my $layer = -1;

my $severity = 0;

for my $i (0 .. $maxdepth) {
    $layer++;
    if ($firewall{$layer} && $scanner{$layer} == 0) {
        $severity += $layer * $firewall{$layer};
    }

    for my $k (keys %firewall) {
        $scanner{$k} += $scannerdir{$k};
        if ($scanner{$k} < 0 || $scanner{$k} >= $firewall{$k}) {
            $scannerdir{$k} *= -1;
            $scanner{$k} += 2*$scannerdir{$k};
        }
    }
}

print "$severity\n";
