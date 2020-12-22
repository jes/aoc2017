#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max sum product any all uniq);

$| = 1;

my $l = <>;
chomp $l;

my @progs = qw(a b c d e f g h i j k l m n o p);

my @instr = split /,/, $l;

my $cyclelength = 0;
my %seen;

my $iters = 0;

my $target = 1_000_000_000;

while ($iters < $target) {
    step();

    my $state = join('', @progs);

    if ($seen{$state} && $target == 1_000_000_000) {
        $cyclelength = $iters - $seen{$state};
        $target = $cyclelength + (1_000_000_000 % $cyclelength);
    }
    $seen{$state} = $iters++;
}

print join('', @progs), "\n";

sub step {
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
}
