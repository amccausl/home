#!/usr/bin/php
<?php

// Search sorted list

function binary_search( $target, &$array )
{
    $lb = 0;
    $ub = count( $array ) - 1;

    do
    {
        $step = ceil( ( $ub - $lb ) / 2 );

        $i = (int)($lb + $step);
        if( $array[ $i ] === $target )
            return $i;

        if( $array[ $i ] > $target )
            $ub = $i;
        else
            $lb = $i;

    } while( $step > 0 );

    return FALSE;
}

function interpolation_search( $target, &$array )
{
    $lb = 0;
    $ub = count( $array ) - 1;

    do
    {
        $interpolation = ( $target - $array[ $lb ] ) / ( $array[ $ub ] - $array[ $lb ] );

        if( $interpolation > 1 || $interpolation < 0 )
            return FALSE;

        $i = $lb + (int)( ( $ub - $lb ) * $interpolation );
        if( $array[ $i ] === $target )
            return $i;

        if( $array[ $i ] > $target )
            $ub = $i;
        else
            $lb = $i;

    } while( $step > 0 );

    return FALSE;
}

$array = [1,2,3,4,5,6,7,8,9];

var_dump( binary_search( 3, $array ) );
var_dump( binary_search( 29, $array ) );

var_dump( interpolation_search( 0, $array ) );
var_dump( interpolation_search( 1, $array ) );
var_dump( interpolation_search( 3, $array ) );
var_dump( interpolation_search( 9, $array ) );
var_dump( interpolation_search( 29, $array ) );
