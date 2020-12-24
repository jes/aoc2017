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

my $longest = 0;
my $maxstr = 0;

strongest(0, {}, 0, 0);
print "$maxstr\n";

sub strongest {
    my ($id, $used, $str, $len) = @_;

    if ($len > $longest) {
        $longest = $len;
        $maxstr = $str;
    } elsif ($len == $longest) {
        $maxstr = $str if $str > $maxstr;
    }

    for my $p (keys %{ $edge{$id} }) {
        next if $used->{"$id,$p"};

        $used->{"$id,$p"} = 1;
        $used->{"$p,$id"} = 1;
        strongest($p, $used, $id+$p+$str, $len+1);
        $used->{"$id,$p"} = 0;
        $used->{"$p,$id"} = 0;
    }
}
