#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

my $l = <>; chomp $l;

my @lengths = split /,/, $l;
my @list = (0..255);
my $cur = 0;
my $skip = 0;
my $start = 0;

for my $l (@lengths) {

    print join(',',@list),"\n";

    @list = (reverse(@list[0..$l-1]), @list[$l..$#list]);

    $start = ($start - $l - $skip);
    $start += @list while $start < 0;
    $start -= @list while $start >= @list;

    $cur = ($l + $skip) % @list;
    @list = (@list[$cur..$#list], @list[0..$cur-1]);
    $cur = 0;

    $skip += 1;
}

print "" . ($list[$start] * $list[($start+1)%@list]) . "\n";
