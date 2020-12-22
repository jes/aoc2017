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
my $delay = 0;

while (1) {

    $scanner{$_} = 0 for keys %scanner;
    $scannerdir{$_} = 1 for keys %scanner;

    my $layer = -1;

    my $caught = 0;

    for my $layer (keys %firewall) {
        next if !$firewall{$layer};

        my $n = ($delay + $layer) % (2*($firewall{$layer}-1));
        if ($n == 0) {
            $caught = 1;
            last;
        }
    }

    last if !$caught;

    $delay++;
}

print "$delay\n";
