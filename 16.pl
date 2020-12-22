#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

my $l = <>;
chomp $l;

my @progs = qw(a b c d e f g h i j k l m n o p);

my @instr = split /,/, $l;

for my $i (@instr) {
    if ($i =~ /^s(\d+)$/) {
        @progs = (@progs[@progs-$1..$#progs], @progs[0..@progs-$1-1]);
    } elsif ($i =~ /^x(\d+)\/(\d+)$/) {
        my $t = $progs[$1];
        $progs[$1] = $progs[$2];
        $progs[$2] = $t;
    } elsif ($i =~ /p(\w)\/(\w)$/) {
        for my $n (0 .. $#progs) {
            if ($progs[$n] eq $1) {
                $progs[$n] = $2;
            } elsif ($progs[$n] eq $2) {
                $progs[$n] = $1;
            }
        }
    } else {
        print "bad: $i\n";
    }
}

print join('', @progs), "\n";
