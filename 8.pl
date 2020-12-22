#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my @prog;
my %register;

while (<>) {
    chomp;

    if (/^(\w+) (inc|dec) ([0-9-]+) if (\w+) ([<>=!]+) ([0-9-]+)$/) {
        my ($register, $op, $amount, $condreg, $condop, $condamt) = ($1, $2, $3, $4, $5, $6);

        $op = ($op eq 'inc' ? '+=' : '-=');

        $register{$register} = 0;

        push @prog, {
            apply => "\$register{\"$register\"} $op $amount",
            cond => "\$register{\"$condreg\"} $condop $condamt",
        };
    } else {
        print "bad: $_\n";
    }
}

for my $p (@prog) {
    eval($p->{apply}) if eval($p->{cond});
}

print max(values %register), "\n";
