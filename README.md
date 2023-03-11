[![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions) [![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions) [![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions)

NAME
====

**Holidays::US::Federal** - Provides names, dates, and dates observed for US Federal holidays

SYNOPSIS
========

```raku
use Holidays::US::Federal;
```

DESCRIPTION
===========

**Holidays::US::Federal** is a module that provides information on the eleven official U.S. federal holidays as of 2023-03-08 according to data available online at [https://www.opm.gov/policy-data-oversight/pay-leave/federal-holidays/](https://www.opm.gov/policy-data-oversight/pay-leave/federal-holidays/). A description of the rules for traditional dates and when holidays are actually observed as paid holidays off for federal employees is also found on the site. All the data reflect current laws. in 5 US Code 6103.

This module provides a routine which provides a hash of the holidays for a given year keyed by each holiday's `date` and `date-observed`. Each key is a Raku `Date` and the key's value is a `class FedHoliday` object. The data are perpetual for any given year as long as 5 US Code 6103 stays unchanged.

For this collection there should be no overlapping holidays. Each instance is one with two different date attributes: (1) the traditional `date` and (2) the `date-observed` which is the paid day-off for most federal government employees (as well as for many other employees in the US labor force). If the dates are identical, then that date is the one to use on a calendar. If they are different, then both should be used.

Note the holidays also have a `short-name` attribute which is not official but has the value used by the author for his calendars.

  * NOTE: During the devlopment of this module, functions for finding dates relative to other dates were found to be necessary and were coded and published as a new Raku module: **Date:Utils**. Those routines are expected to be useful for various calendar creation. They are:

      * `nth-day-of-week-in-month`

      * `nth-day-of-week-after-date`

    For convenience, the routines have alternative names requiring fewer key strokes. They are:

      * `nth-dow-in-month`

      * `nth-dow-after-date`

Example use
-----------

    use Holidays:US::Federal;
    class FedHoliday is Date::Event {};
    sub get-fedholidays(:$year!, :$debug --> Hash) is export {
        my FedHoliday @h = get-fedholidays $year;
        @h
    }

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2023 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

