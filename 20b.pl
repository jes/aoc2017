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
            dead => 0,
        }
    } else {
        print "bad: $_\n";
    }
}

my $oldcount = 0;

while (1) {
    my %got;

    for my $p (@particles) {
        next if $p->{dead};

        $p->{v}[$_] += $p->{a}[$_] for (0..2);
        $p->{p}[$_] += $p->{v}[$_] for (0..2);

        my $loc = join(',', @{ $p->{p} });
        $p->{loc} = $loc;
        $got{$loc}++;
    }

    my $count = 0;
    for my $p (@particles) {
        next if $p->{dead};
        $p->{dead} = 1 if $got{$p->{loc}} > 1;
        $count++ if !$p->{dead};
    }

    if ($count != $oldcount) {
        print "$count\n";
        $oldcount = $count;
    }
}
