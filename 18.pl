#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my %register;

my $lastsound;

my @program;

while (<>) {
    chomp;

    if (/^(\w+) ([a-z0-9-]+)(?: ([a-z0-9-]+))?$/) {
        my ($instr, $op1, $op2) = ($1, $2, $3);
        push @program, [$instr, $op1, $op2];
    } else {
        print "bad: $_\n";
    }
}

my $pc = -1;
while (1) {
    $pc++;
    tick(@{ $program[$pc] });
}

sub deref {
    my ($v) = @_;

    return $v if $v =~ /\d/;

    return $register{$v}||0;
}

sub tick {
    my ($instr, $op1, $op2) = @_;

    my $v1 = deref($op1);
    my $v2 = $op2 ? deref($op2) : 0;

    if ($instr eq 'snd') {
        $lastsound = $v1;
    } elsif ($instr eq 'set') {
        $register{$op1} = $v2;
    } elsif ($instr eq 'add') {
        $register{$op1} = $v1 + $v2;
    } elsif ($instr eq 'mul') {
        $register{$op1} = $v1 * $v2;
    } elsif ($instr eq 'mod') {
        $register{$op1} = $v1 % $v2;
    } elsif ($instr eq 'rcv') {
        if ($v1 != 0) {
            print "$lastsound\n";
            exit;
        }
    } elsif ($instr eq 'jgz') {
        $pc += $v2-1 if $v1 > 0;
    } else {
        print "bad instr: $instr\n";
    }

}
