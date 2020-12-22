#!/usr/bin/perl

use strict;
use warnings;

my $in = <>;
chomp $in;

my @c = split //, $in;

my $r = 0;

for my $i (0 .. $#c) {
    my $n = ($i+1)%@c;
    $r += $c[$i] if $c[$i] == $c[$n];
}

print "$r\n";
