#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(any all min max sum product uniq);

my $n = 0;

my @names;
my %children;
my %parent;
my %weight;

while (<>) {
    chomp;

    if (/^(\w+) \((\d+)\) -> ([a-z, ]+)$/) {
        my ($name, $weight, $programs_above) = ($1, $2, $3);
        push @names, $name;
        push @{ $children{$name} }, $_ for split /, /, $programs_above;
        $parent{$_} = $name for split /, /, $programs_above;
        $weight{$name} = $weight;
    } elsif (/^(\w+) \((\d+)\)$/) {
        my ($name, $weight) = ($1, $2);
        push @names, $name;
        $weight{$name} = $weight;
    } else {
        print "bad: $_\n";
    }
}

my $root;

for my $n (@names) {
    $root = $n if !$parent{$n};
}

dfs($root);

sub dfs {
    my ($node) = @_;

    my @child_weights;

    for my $c (@{ $children{$node} }) {
        push @child_weights, dfs($c);
    }

    for my $i (1 .. $#child_weights) {
        if ($child_weights[$i] != $child_weights[0]) {
            print "$_\n" for @{ $children{$node} };
            print "$_\n" for @child_weights;
            print "Now look at the input, work out how much to change the weight of the odd one out, and submit the answer...\n";
            exit;
        }
    }

    return $weight{$node} + (@child_weights ? sum(@child_weights) : 0);
}
