#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(any all min max product sum uniq);

my $in = <>;
chomp $in;

while ($in =~ /!./) {
    $in =~ s/!.//;
}

while ($in =~ /<[^>]*>/) {
    $in =~ s/<[^>]*>//;
}

$in =~ s/,//g;

print "$in\n";

my $n = 0;
my $level = 0;

my @c = split //, $in;

for my $c (@c) {
    if ($c eq '{') {
        $level++;
    } elsif ($c eq '}') {
        $n += $level;
        $level--;
    }
}

print "$n\n";
