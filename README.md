[![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions) [![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions) [![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions)

NAME
====

**Holidays::US::Federal** - Provides names, dates, and dates observed for US Federal holidays

SYNOPSIS
========

```raku
use Holidays::US::Federal;
use UUID::V4;

my $year = 2025;
my $set-id = uuid-v4; # A unique ID for the set of holidays so they can be
                      # merged with other C<Date::Event> sets for calendar
                      # generation;
my %us = get-fedholidays :$year, :$set-id;
# Keys of the '%us' hash are the C<$year>'s dates with holidays
my @d = %us.keys.sort({$^a cmp $^b}); # Get array in date order
for @d -> $D {
    my Date $date .= new: $D; # Get the Date
    my %h = %us{$date};       # All the events on that date, should always be 1 for
                              # this set of US holidays
    # The value of %h is another hash keyed by: ($set-id ~ '|' ~ $id)
    # but we only break that key down for testing.
    #    %h{$h.date}{$key} = $holiday;
    my $holiday;
    for %h.keys -> $key {
        $holiday = %h{$key}; # The C<FedHoliday> class object (a C<Date::Event>)
        # use the data for a calendar day cell
        my $d  = $holiday.date;
        my $do = $holiday.date-observed;
        my $n  = $holiday.name;
        my $ns = $holiday.short-name;
    }
}
```

For simpler use, we can get a hash also keyed by Date, but whose values are lists of holiday events:

    my %us = get-fedholidays-hashlist :$year;
    for %us.keys.sort -> $date {
        for @(%us{$date}) -> $holiday {
            my $n = $holiday.name;
        }
    }

DESCRIPTION
===========

**Holidays::US::Federal** is a module that provides information on the eleven official U.S. federal holidays as of 2023-03-08 according to data available online at [https://www.opm.gov/policy-data-oversight/pay-leave/federal-holidays/](https://www.opm.gov/policy-data-oversight/pay-leave/federal-holidays/). A description of the rules for traditional dates and when holidays are actually observed as paid holidays off for federal employees is also found on the site. All the data reflect current laws in Title 5 US Code Section 6103.

This module provides two routines which provide a hash of the holidays for a given year keyed by each holiday's traditional date. Each key is a Raku `Date`, and the key's value is either (1) a `class FedHoliday is Date::Event` object or a list of the same. The data are perpetual for any given year as long as Title 5 US Code Section 6103 stays unchanged.

For this collection there should be no overlapping holidays. Each instance is one with two different date attributes: (1) the traditional `date` and (2) the `date-observed` which is the paid day-off for most federal government employees (as well as for many other employees in the US labor force). If the dates are identical, then that date is the only one to use on a calendar. If they are different, then both should be used.

Note the holidays also have a `short-name` attribute which is not official but has the value used by the author for his calendars in order to fit nicely in a day cell on Letter paper using the author's `Calendar` module. With that style, day cells should be a bit wider (but shorter) when using A4 paper, so the official name may fit satisfactorily in that case. Please file an issue if you have a suggested 'short-name' for those currently without a value.

  * NOTE: During the devlopment of this module, functions for finding dates relative to other dates were found to be necessary and were coded and published as a new Raku module: **Date:Utils**. Those routines are expected to be useful for various calendar creation projects. They are:

      * `nth-day-of-week-in-month`

      * `nth-day-of-week-after-date`

    For convenience, the routines have alternative names requiring fewer key strokes. They are:

      * `nth-dow-in-month`

      * `nth-dow-after-date`

SEE ALSO
========

Related Raku modules by the author:

  * **Date::Christian::Advent**

  * **Date::Easter**

  * **Holidays::Miscellaneous**

  * **Calendar**

  * **Date::Event**

  * **Date::Utils**

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

