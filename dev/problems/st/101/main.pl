#!/usr/bin/perl

use strict;
use warnings;

open( INPUT, "<in.txt" );

my $n = <INPUT>;
chomp( $n );

my %stacks = ();
my %blocks = ();

for( my $i = 0; $i < $n; $i++ )
{
    push( @{$stacks{ $i }}, $i );
    $blocks{ $i } = $i;
}

sub reset
{
    my ( $a ) = @_;
    my $a_i = $blocks{ $a };
    my $pop;

    # Move everything off of $a
    $pop = pop( @{$stacks{$a_i}} );
    while( $pop != $a )
    {
        $blocks{ $pop } = $pop;
        push( @{$stacks{ $pop }}, $pop );
        $pop = pop( @{$stacks{$a_i}} );
    }
}

sub pop
{
    my ( $a ) = @_;
    my $a_i = $blocks{ $a };
    my @temp_stack = ();
    my $pop;

    # Grab everything above $a
    $pop = pop( @{$stacks{$a_i}} );
    while( $pop != $a )
    {
        push( @temp_stack, $pop );
        $pop = pop( @{$stacks{$a_i}} );
    }
    push( @temp_stack, $pop );

    return( @temp_stack );
}

sub move_onto
{
    my ( $a, $b ) = @_;

    # Find the locations for $b
    my $b_i = $blocks{ $b };

    # Move everything off of $a
    &reset( $a );

    # Move everything off of $b
    &reset( $b );

    # Move $a onto $b
    push( @{$stacks{ $b_i }}, $b );
    $blocks{ $b } = $b_i;
    push( @{$stacks{ $b_i }}, $a );
    $blocks{ $a } = $b_i;
}

sub move_over
{
    my ( $a, $b ) = @_;

    # Find the locations for $b
    my $b_i = $blocks{ $b };

    # Move everything off of $a
    &reset( $a );

    # Move $a over $b
    push( @{$stacks{ $b_i }}, $a );
    $blocks{ $a } = $b_i;
}

sub pile_onto
{
    my ( $a, $b ) = @_;

    my $a_i = $blocks{ $a };
    my $b_i = $blocks{ $b };
    my $pop;
    my @temp_stack = ();

    # Move everything off of $b
    &reset( $b );

    # Put $b back
    push( @{$stacks{ $b_i }}, $b );
    $blocks{ $b } = $b_i;

    # Grab everything above $a
    my @above_a = &pop( $a );

    while( my $block = CORE::pop( @above_a ) )
    {
        push( @{$stacks{ $b_i }}, $block );
        $blocks{ $block } = $b_i;
    }
}

sub pile_over
{
    my ( $a, $b ) = @_;

    my $b_i = $blocks{ $b };

    # Grab everything above $a
    my @above_a = &pop( $a );

    # Stack them above $b
    while( my $block = CORE::pop( @above_a ) )
    {
        push( @{$stacks{ $b_i }}, $block );
        $blocks{ $block } = $b_i;
    }
}

while( <INPUT> )
{
    my( $line ) = $_;
    chomp( $line );

    my $cmd;

    if( $line =~ /move (\d+) onto (\d+)/ )
    {
        $cmd = \&move_onto;
    }
    elsif( $line =~ /move (\d+) over (\d+)/ )
    {
        $cmd = \&move_over;
    }
    elsif( $line =~ /pile (\d+) onto (\d+)/ )
    {
        $cmd = \&pile_onto;
    }
    elsif( $line =~ /pile (\d+) over (\d+)/ )
    {
        $cmd = \&pile_over;
    }
    elsif( $line =~ /quit/ )
    {
        foreach my $key ( sort keys %stacks )
        {
            print "$key:";
            foreach ( @{$stacks{$key}} )
            {
                print " $_";
            }
            print "\n";
        }
        exit;
    }
    else
    {
        print "parse fail\n";
    }

    if( $1 != $2 )
    {
        &$cmd( $1, $2 );
    }
}
