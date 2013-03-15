#!/usr/bin/perl

use strict;
use warnings;
no warnings 'recursion';

# Best: n, Average: n^2, Worst: n^2, Memory: 1, Stable: Yes
sub bubble_sort {
    my $count = 0;
    my ( @array ) = @_;
    my $sorted = 0;

    while( ! $sorted )
    {
        $sorted = 1;
        for( my $i = 0; $i < @array - 1; $i++ )
        {
            $count++;

            if( $array[$i] > $array[$i + 1] )
            {
                $sorted = 0;
                my $i_0 = $array[$i];
                my $i_1 = $array[$i+1];
                ( $array[$i], $array[$i+1] ) = ( $i_1, $i_0 );
            }
        }
    }

    return ( (caller(0))[3], \@array, $count );
}

# Best: n^2, Average: n^2, Worst: n^2, Memory: 1, Stable: No
sub selection_sort {
    my $count = 0;
    my ( @array ) = @_;

    for( my $i = 0; $i < @array; $i++ )
    {
        my $min = $array[ $i ];
        my $target = $i;
        for( my $j = $i + 1; $j < @array; $j++ )
        {
            $count++;

            if( $array[ $j ] < $min )
            {
                $min = $array[ $j ];
                $target = $j;
            }
        }

        # Swap
        $array[ $target ] = $array[ $i ];
        $array[ $i ] = $min;
    }

    return ( (caller(0))[3], \@array, $count );
}

# Best: n, Average: n^2, Worst: n^2, Memory: 1, Stable: Yes
sub insertion_sort {
    my $count = 0;
    my ( @array ) = @_;

    for( my $i = 1; $i < @array; $i++ )
    {
        $count++;
        my $x = $array[ $i ];
        my $j = $i - 1;
        while( $j >= 0 && $array[ $j ] > $x )
        {
            $count++;
            $array[ $j + 1 ] = $array[ $j ];
            $array[ $j ] = $x;
            $j--;
        }
    }

    return ( (caller(0))[3], \@array, $count );
}

# Best: nlog n, Average: nlog n, Worst: nlog n, Memory: n, Stable: Yes
sub merge_sort {
    my $count = 0;
    my ( @array ) = @_;

    if( @array == 1 )
    {
        return ( (caller(0))[3], \@array, 0 );
    }

    my $pivot = int(@array / 2);
    my ( $n_0, $a_0, $c_0 ) = &merge_sort( splice @array, 0, $pivot );
    my ( $n_1, $a_1, $c_1 ) = &merge_sort( @array );

    my @result = ();
    while( @{ $a_0 } || @{ $a_1 } )
    {
        $count++;
        if( ! @{ $a_1 } )
        {
            push( @result, shift( @{ $a_0 } ) );
        }
        elsif( ! @{ $a_0 } || $$a_0[ 0 ] > $$a_1[ 0 ] )
        {
            push( @result, shift( @{ $a_1 } ) );
        }
        else
        {
            push( @result, shift( @{ $a_0 } ) );
        }
    }

    return ( (caller(0))[3], \@result, $count + $c_0 + $c_1 );
}

# Best: nlog n, Average: nlog n, Worst: n^2, Memory: log n, Stable: Yes
sub quick_sort {
    my ( @array ) = @_;

    if( @array == 1 )
    {
        return ( (caller(0))[3], \@array, 0 );
    }

    return ( (caller(0))[3], \@array, &quick_sort_helper( \@array, 0, $#array ) );
}

sub quick_sort_helper {
    my $count = 0;
    my ( $array, $lower, $upper ) = @_;

    my $pivot = ${ $array }[ $upper ];
    my $i = $lower;
    my $j = $upper - 1;

    if( $lower >= $upper )
    {
        return 1;
    }

    if( $lower == $upper - 1 )
    {
        if( ${ $array }[ $lower ] > ${ $array }[ $upper ] )
        {
            ${ $array }[ $upper ] = ${ $array }[ $lower ];
            ${ $array }[ $lower ] = $pivot;
        }
        return 1;
    }

    while( 1 )
    {
        while( ${ $array }[ $i ] <= $pivot && $i < $j )
        {
            $count++;
            $i++;
        }

        while( ${ $array }[ $j ] > $pivot && $i < $j )
        {
            $count++;
            $j--;
        }

        if( $i >= $j )
        {
            last;
        }

        # Exchange $i and $j
        my $temp = ${ $array }[ $j ];
        ${ $array }[ $j ] = ${ $array }[ $i ];
        ${ $array }[ $i ] = $temp;
    }

    # Move pivot input
    if( $j != $upper - 1 || ${ $array }[ $upper ] < ${ $array }[ $j ] )
    {
        ${ $array }[ $upper ] = ${ $array }[ $j ];
        ${ $array }[ $j ] = $pivot;

        # Recurse
        $count += &quick_sort_helper( $array, $lower, $j - 1 );
        $count += &quick_sort_helper( $array, $j + 1, $upper );
    }
    else
    {
        # Recurse
        $count += &quick_sort_helper( $array, $lower, $j );
    }

    return $count;
}

# Best: nlog n, Average: nlog n, Worst: nlog n, Memory: 1, Stable: No
sub heap_sort {

}

sub heapify {
    my ( $array ) = @_;
    my $i = 0;

    for( my $depth = 1; $i < @{$array}; $depth++ )
    {
        my $bound = 2**$depth - 1 < @{$array} ? 2**$depth - 1 : @{$array};
        for( ; $i < $bound; $i++ )
        {
            my $current = $i;
            my $parent_depth = $depth - 1;
            my $parent = int( ( $current - 1 ) / 2 );

            while( $parent_depth > 0 && ${$array}[ $parent ] > ${$array}[ $current ] )
            {
                my $temp = ${$array}[ $parent ];
                ${$array}[ $parent ] = ${$array}[ $current ];
                ${$array}[ $current ] = $temp;

                $parent_depth--;
                $current = $parent;
                $parent = int( ( $current - 1 ) / 2 );
            }
        }
    }
}

my @input_1 = (2,5,3,2,6,7,98,0,2);
my @input_2 = (1,2,3,4,5,6,7,9,8,10);

my @heap = (1..32);
&heapify( \@heap );
print( "heap = @heap\n" );

my @sort_algos = ( \&bubble_sort, \&selection_sort, \&insertion_sort, \&merge_sort, \&quick_sort );

foreach my $f (@sort_algos)
{
    my ( $name, $array, $count ) = &{ $f }( @input_1 );
    print( "*** $name ***\n" );

    print( "input: @input_1\n" );
    print( "finish: $count operations\n" );
    print( "@{$array}\n\n" );

    ( $name, $array, $count ) = &{ $f }( @input_2 );

    print( "input: @input_2\n" );
    print( "finish: $count operations\n" );
    print( "@{$array}\n\n" );
}