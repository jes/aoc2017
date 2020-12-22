#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(max min);

my $n = 0;

while (<>) {
    chomp;
    my @nums = split /\s/;
    for my $a (@nums) {
        for my $b (@nums) {
            next if $a == $b;
            $n += ($a / $b) if ($a%$b==0);
        }
    }
}

print "$n\n";
