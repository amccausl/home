#!/usr/bin/perl

use strict;
use warnings;

sub parse
{
    ( my $line, my $tree_ref ) = @_;

    while( $line )
    {
        if( $line =~ s/^(\d+)//gs )
        {
            push( @{ $tree_ref }, $1 );
        }
        elsif( $line =~ s/^\(//gs )
        {
            my $sub_tree = [];
            $line = &parse( $line, $sub_tree );
            push( @{ $tree_ref }, $sub_tree );
        }
        elsif( $line =~ s/^\)//gs )
        {
            return $line;
        }
    }

    return $tree_ref;
}

sub has_path
{
    ( my $target_cost, my $tree_ref ) = @_;

    my $node_cost = shift( @{ $tree_ref } );

    $target_cost -= $node_cost;

    if( $#{ $tree_ref } == -1 && $target_cost == 0 )
    {
        return 1;
    }

    foreach my $tree ( @{ $tree_ref } )
    {
        if( &has_path( $target_cost, $tree ) )
        {
            return 1;
        }
    }
    return 0;
}

open( INPUT, "<in.txt" );

my $line = "";

while( <INPUT> )
{
    $line .= $_;
    chomp( $line );

    if( ( $line =~ tr/\(// ) == ( $line =~ tr/\)// ) )
    {
        my $tree = [ 0 ];

        $line =~ s/\(\)//gs;
        $line =~ s/\s*//gs;
        $line =~ /(\d+)(.*)/;

        if( $2 eq "" )
        {
            print "no\n";
        }
        else
        {
            &parse( $2, $tree );

            if( &has_path( $1, $tree ) )
            {
                print "yes\n";
            }
            else
            {
                print "no\n";
            }
        }

        $line = "";
    }
}

