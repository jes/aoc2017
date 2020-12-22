#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max any all product sum uniq);

my %register;

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

my %pc = (0 => -1, 1 => -1);
my $machine = 0;
my %recv = (0 => [], 1 => []);

my $num1sent = 0;

$register{0}{p} = 0;
$register{1}{p} = 1;

while (1) {
    $pc{$machine}++;
    if ($pc{$machine} >= @program) {
        print "machine $machine exits; num1sent=$num1sent\n";
    }
    tick(@{ $program[$pc{$machine}] });
}

sub deref {
    my ($v) = @_;

    return $v if $v =~ /\d/;

    return $register{$machine}{$v}||0;
}

sub tick {
    my ($instr, $op1, $op2) = @_;

    $op2 ||= '';

    my $v1 = deref($op1);
    my $v2 = $op2 ? deref($op2) : 0;

    if ($instr eq 'snd') {
        push @{ $recv{$machine ? 0 : 1} }, $v1;
        $num1sent++ if $machine == 1;
    } elsif ($instr eq 'set') {
        $register{$machine}{$op1} = $v2;
    } elsif ($instr eq 'add') {
        $register{$machine}{$op1} = $v1 + $v2;
    } elsif ($instr eq 'mul') {
        $register{$machine}{$op1} = $v1 * $v2;
    } elsif ($instr eq 'mod') {
        $register{$machine}{$op1} = $v1 % $v2;
    } elsif ($instr eq 'rcv') {
        if (@{ $recv{$machine} }) {
            $register{$machine}{$op1} = shift @{ $recv{$machine} };
        } else {
            $pc{$machine}--; # re-enter the same instruction when we return to this machine
            $machine = $machine ? 0 : 1; # swap back to other machine

            # deadlock if other machine is also waiting on rcv
            if ($program[$pc{$machine}+1][0] eq 'rcv' && !@{ $recv{$machine} }) {
                print "deadlock\n";
                print "$num1sent\n";
                exit;
            }
        }
    } elsif ($instr eq 'jgz') {
        $pc{$machine} += $v2-1 if $v1 > 0;
    } else {
        print "bad instr: $instr\n";
    }

}
