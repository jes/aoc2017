#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(any all min max product sum uniq);

my $in = <>;
chomp $in;

while ($in =~ /!./) {
    $in =~ s/!.//;
}

my $before_len = length($in);

while ($in =~ /<[^>]*>/) {
    $in =~ s/<[^>]*>//;
    $before_len -= 2;
}

my $removed = $before_len - length($in);

print "$removed\n";
