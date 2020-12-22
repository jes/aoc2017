#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all sum product uniq);

my %grid = map { $_ => '#' } qw(0,1 1,2 2,0 2,1 2,2);

for my $y (0 .. 2) {
    for my $x (0 .. 2) {
        $grid{"$y,$x"} ||= '.';
    }
}
$grid{max}=2;

my %rules;

while (<>) {
    chomp;

    if (/^(..\/..) => (...\/...\/...)$/) {
        $rules{$_} = $2 for parse_rule($1);
    } elsif (/^(...\/...\/...) => (....\/....\/....\/....)$/) {
        $rules{$_} = $2 for parse_rule($1);
    } else {
        print "bad: $_\n";
    }
}

for (1..18) {
    %grid = iterate(\%grid);
    print "$_:\n";

   print scalar(grep { $_ eq '#' } values %grid), "\n";
}

print scalar(grep { $_ eq '#' } values %grid), "\n";

sub fourwayequal {
    my ($map) = @_;

    my $max = findmax($map);
    return if (($max+1)%2) != 0;
    my $size = ($max+1)/2;

    print "Size=$size\n";
    
    for my $y (0..$size-1) {
        for my $x (0..$size-1) {
            my $x2 = $x+$size;
            my $y2 = $y+$size;
            my $g = $map->{"$y,$x"};
            print "Try ($x,$y)=$g to ($x2,$y2)=" . $map->{"$y2,$x2"} . "\n";
            print "Match: $g to " . join('', $map->{"$y2,$x"}, $map->{"$y,$x2"}, $map->{"$y2,$x2"}), "\n";
            return 0 if any { $_ ne $g } ($map->{"$y2,$x"}, $map->{"$y,$x2"}, $map->{"$y2,$x2"});
        }
    }

    return 1;
}

sub iterate {
    my ($map) = @_;

    my $newmap = {};

    my $max = findmax($map);

    my $step = (($max+1)%2 == 0) ? 2 : 3;

    my ($outx, $outy) = (0, 0);
    for (my $y = 0; $y < $max; $y += $step) {
        $outx = 0;
        for (my $x = 0; $x < $max; $x += $step) {
            my $key = strify($map, 0, $step-1, $x, $y);
            plotmap($rules{$key}, $newmap, $outx, $outy);
            $outx += $step+1;
        }
        $outy += $step+1;
    }

    return %$newmap;
}

sub findmax {
    my ($map) = @_;

    return $map->{max} if exists $map->{max};

    # XXX: too slow?

    my $i = 0;
    while (1) {
        return $i-1 if !exists $map->{"$i,0"};
        $i++;
    }
}

sub parse_rule {
    my ($rule) = @_;

    my $map = plotmap($rule, {});

    my @results;

    for my $o (0..7) {
        push @results, strify($map, $o);
    }

    return @results;
}

sub plotmap {
    my ($pattern, $map, $ox, $oy) = @_;

    $ox ||= 0;
    $oy ||= 0;

    $map->{max} ||= 0;

    my $y = $oy;
    for my $row (split /\//, $pattern) {
        my $x = $ox;
        for my $c (split //, $row) {
            $map->{"$y,$x"} = $c;
            $map->{max} = $x if $x > $map->{max};
            $x++;
        }
        $map->{max} = $y if $y > $map->{max};
        $y++;
    }

    return $map;
}

sub strify {
    my ($map, $orientation, $max, $ox, $oy) = @_;

    $max ||= findmax($map);
    $ox ||= 0;
    $oy ||= 0;

    my @rows;

    for my $y (0..$max) {
        my $r = '';
        for my $x (0..$max) {
            my $py = $y+$oy;
            my $px = $x+$ox;
            $r .= get_pixel($map, $orientation, $px, $py);
        }
        push @rows, $r;
    }

    return join('/', @rows);
}

sub get_pixel {
    my ($map, $orientation, $x, $y) = @_;

    # orientations:
    # 0 - default
    # 1 - rot90
    # 2 - rot180
    # 3 - rot270

    my $max = findmax($map);

    # >= 4 - subtract 4 and invert y
    if ($orientation >= 4) {
        $orientation -= 4;
        $y = $max-$y;
    }

    ($x,$y) = ($max-$y,$x) for (1..$orientation);

    return $map->{"$y,$x"};
}

