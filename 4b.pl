#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(any);

my $n = 0;

while (<>) {
    chomp;

    my @w = map { join('', sort(split //, $_)) } split / /;
    my %c;
    $c{$_}++ for @w;

    $n++ unless any { $c{$_} > 1 } keys %c;
}

print "$n\n";
