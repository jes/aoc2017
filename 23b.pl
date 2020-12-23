#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my ($a,$b,$c,$d,$e,$f,$g,$h) = (0)x8;

$a = 1;

$b = 108100;
$c = $b + 17000;

while (1) {
    $f = 1;
    $d = 2;

    $h++ if is_composite($b);

    if ($b == $c) {
        print "$h\n";
        exit;
    }
    $b += 17;
}

sub is_composite {
    my ($b) = @_;

    for (my $a = 2; $a*$a < $b; $a++) {
        return 1 if $b%$a == 0;
    }

    return 0;
}
