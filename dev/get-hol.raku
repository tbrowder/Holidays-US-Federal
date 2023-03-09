#!/usr/bin/env raku

use lib <../lib>;
use Holidays::US::Federal;

if not @*ARGS.elems {
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} go

    Checks various aspects of this module
    HERE
    exit;
}

my @k = %holidays.keys.sort({$^a <=> $^b});

if 0 {
for @k -> $K {
    my %h = %holidays{$K};
    say "Key $K";
    for %h.kv -> $k, $v {
        print qq:to/HERE/;
            $k => $v
        HERE
    }
}
}

my $year = 2023;
my $debug = 1;
for @k -> $K {
    my %h = %holidays{$K};
    my $name = %h<name>;
    my $date = %h<date>;
    my $date-observed = %h<date-observed>;
    my $key = %h<key>;
    
    get-observed-day(:$year, :$key, :%holidays, :$debug); # --> Date) is export {
    
    #calc-date(:$name, :$year, :$debug); # is export {
}
