#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

my $l = <>; chomp $l;

my @lengths = map { ord($_) } split //, $l;
push @lengths, (17,31,73,47,23);
my @list = (0..255);
my $cur = 0;
my $skip = 0;
my $start = 0;

for (1..64) {
    for my $l (@lengths) {
        @list = (reverse(@list[0..$l-1]), @list[$l..$#list]);

        $start = ($start - $l - $skip);
        $start += @list while $start < 0;
        $start -= @list while $start >= @list;

        $cur = ($l + $skip) % @list;
        @list = (@list[$cur..$#list], @list[0..$cur-1]);
        $cur = 0;

        $skip += 1;
    }
}

my @dense;

for my $a (0..15) {
    my $v = 0;
    for my $b (0..15) {
        $v ^= $list[($start+$a*16+$b)%@list];
    }
    push @dense, $v;
}

print join('', map { sprintf("%02x", $_) } @dense), "\n";
