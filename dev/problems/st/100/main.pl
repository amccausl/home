#!/usr/bin/perl

use strict;
use warnings;
no warnings 'recursion';

my $solutions = { 1 => 1 };

my $ubound = 1000000;

sub f
{
    my ( $n ) = @_;

    if( ! exists $solutions->{ $n } )
    {
        if( $n % 2 == 1 )
        {
            $solutions->{ $n } = 1 + &f( 3 * $n + 1 );
        }
        else
        {
            $solutions->{ $n } = 1 + &f( $n / 2 );
        }
    }

    return( $solutions->{ $n } );
}

open( INPUT, "<in.txt" );
while( <INPUT> )
{
    my( $line ) = $_;
    chomp( $line );
    if( $line =~ /(\d+) +(\d+)/ )
    {
        my $max = 0;

        for( my $i = $1; $i <= $2; $i++ )
        {
            if( &f( $i ) > $max )
            {
                $max = &f( $i );
            }
        }
        print( "$1 $2 $max\n" );
    }
    else
    {
        print "parse fail\n";
    }
}
