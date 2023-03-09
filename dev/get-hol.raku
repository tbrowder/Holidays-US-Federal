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


