[![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions) [![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions) [![Actions Status](https://github.com/tbrowder/Holidays-US-Federal/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Holidays-US-Federal/actions)

NAME
====

**Holidays::US::Federal** - Provides dates, names, alternate names, and dates observed for US Federal holidays

SYNOPSIS
========

```raku
use Holidays::US::Federal;
```

DESCRIPTION
===========

**Holidays::US::Federal** is a module that provides information on official U.S. federal holidays as of 2023-03-08 according to data available online at [https://www.opm.gov/policy-data-oversight/pay-leave/federal-holidays/](https://www.opm.gov/policy-data-oversight/pay-leave/federal-holidays/). A description of the rules for traditional dates and when holidays are actually observed as paid holidays off for federal employees is also found in the PDF document in the `/docs` directory herein.

The module provides one routine which provides a list of the holidays for a given year. The list consists of an entry for each holiday with pertinent data for each.

    use Date::Event;
    class FedHoliday is Date::Event {};
    sub fed-holidays(:$year!, :$debug --> List) is export {
        my FedHoliday @h = get-holidays $year;
        @h
    }

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2023 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

