#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(max min);

my $n = 0;

while (<>) {
    chomp;
    my @nums = split /\s/;
    $n += max(@nums) - min(@nums);
}

print "$n\n";
