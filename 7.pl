#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(any all min max sum product uniq);

my $n = 0;

my @names;
my %is_held;

while (<>) {
    chomp;

    if (/^(\w+) \((\d+)\) -> ([a-z, ]+)$/) {
        my ($name, $weight, $programs_above) = ($1, $2, $3);
        push @names, $name;
        $is_held{$_} = 1 for split /, /, $programs_above;
    } elsif (/^(\w+) \((\d+)\)$/) {
        my ($name, $weight) = ($1, $2);
        push @names, $name;
    } else {
        print "bad: $_\n";
    }
}

for my $n (@names) {
    print "$n\n" if !$is_held{$n};
}
