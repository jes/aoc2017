#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

my $in = 'oundnydw';

my $n = 0;

my %map;

my $y = 0;

my $regions = 0;

my $nonregions = 0;

my %regionssame;

for my $i (0..127) {
    my $hex = knothash("$in-$i");
    my @bin = map { split //, sprintf("%04b", hex($_)) } split //, $hex;
    @bin = (0,@bin) while @bin < 128;

    for my $x (0..127) {
        my $ym1 = $y-1;
        my $xm1 = $x-1;
        next if !$bin[$x];
        if ($map{"$ym1,$x"} && $map{"$y,$xm1"} && ($map{"$ym1,$x"} ne $map{"$y,$xm1"})) {
            $nonregions++;
            my $keep = $map{"$ym1,$x"};
            my $remove = $map{"$y,$xm1"};
            for my $k (keys %map) {
                $map{$k} = $keep if $map{$k} eq $remove;
            }
            $map{"$y,$x"} = $keep;
        } elsif ($map{"$ym1,$x"}) {
            $map{"$y,$x"} = $map{"$ym1,$x"};
        } elsif ($map{"$y,$xm1"}) {
            $map{"$y,$x"} = $map{"$y,$xm1"};
        } else {
            $map{"$y,$x"} = ++$regions;
        }
    }

    $y++;
}

print "$regions\n";
print "$nonregions\n";

print "" . ($regions - $nonregions) . "\n";

sub knothash {
    my ($l) = @_;

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

    return join('', map { sprintf("%02x", $_) } @dense);
}
