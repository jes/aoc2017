#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my $n = 0;

my @ports;

my %edge;

while (<>) {
    chomp;

    my ($a,$b) = split /\//;
    push @ports, [$a,$b];

    $edge{$a}{$b} = 1;
    $edge{$b}{$a} = 1;
}

print strongest(0, {}), "\n";

sub strongest {
    my ($id, $used) = @_;

    my $possible = 0;

    for my $p (keys %{ $edge{$id} }) {
        next if $used->{"$id,$p"};

        $used->{"$id,$p"} = 1;
        $used->{"$p,$id"} = 1;
        my $str = $id + $p + strongest($p, $used);
        $possible = $str if $str > $possible;
        $used->{"$id,$p"} = 0;
        $used->{"$p,$id"} = 0;
    }

    return $possible;
}
