unit module Holidays::US::Federal;

# 11 federal holidays as legislated in 5 U.S. Code S 6103
our %hols is export = [
    {
        name => "New Year's Day",
        short-name => "",
        date => "0000-01-01",
        date-observed => &get-new-years-day,
    },
    {
        name => "Birthday of Martin Luther King, Jr.",
        short-name => "",
        date => "", # third Monday of January
        date-observed => &get-mlk-day,
    },
    {
        name => "Washington's Birthday",
        short-name => "",
        date => "", # third Monday of February
        date-observed => &get-gw-day,
    },
    {
        name => "Memorial Day",
        short-name => "",
        date => "", # last Monday in May
        date-observed => &get-mem-day,
    },
    {
        name => "Juneteenth National Independence Day",
        short-name => "",
        date => "0000-06-19", 
        date-observed => &get-jni-day,
    },
    {
        name => "Independence Day",
        short-name => "",
        date => "0000-07-04", 
        date-observed => &get-j4th-day,
    },
    {
        name => "Labor Day",
        short-name => "",
        date => "", # first Monday in September 
        date-observed => &get-labor-day,
    },
    {
        name => "Columbus Day",
        short-name => "",
        date => "", # second Monday in October 
        date-observed => &get-columbus-day,
    },
    {
        name => "Veterans Day",
        short-name => "0000-11-11",
        date => "", # month and day of the armistice ending WW I fighting  
        date-observed => &get-vets-day,
    },
    {
        name => "Thanksgiving Day",
        short-name => "",
        date => "", # fourth Thursday in November
        date-observed => &get-thanks-day,
    },
    {
        name => "Christmas Day",
        short-name => "",
        date => "0000-12-31",   
        date-observed => &get-xmas-day,
    },


];

# Routines for calculating dates observed for federal holidays:
# There are two types:
#   1. Those holidays designated as a certain day of the month.
#   2. Those holidays with assigned dates that may fall on
#      weekends. When the date for a year falls on a Saturday,
#      it is observed on the previous Friday. When the date falls
#      on a Sunday, it is observed on the following Monday.

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}

sub get--day(:$year!, :$debug --> Date) is export {
}


