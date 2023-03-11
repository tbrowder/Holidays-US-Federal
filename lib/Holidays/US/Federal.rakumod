unit module Holidays::US::Federal;

use Date::Utils;
use Date::Event;

class FedHoliday is Date::Event {};

# 11 federal holidays as legislated in 5 U.S. Code S 6103
#    names are as specified in that law
our %fedholidays is export = [
    1 => {
        name => "New Year's Day",
        date => "0000-01-01",
        date-observed => "", 
        short-name => "",
        id => 1,
    },
    5 => {
        name => "Juneteenth National Independence Day",
        date => "0000-06-19", 
        date-observed => "", 
        short-name => "",
        id => 5,
    },
    6 => {
        name => "Independence Day",
        date => "0000-07-04", 
        date-observed => "",
        short-name => "",
        id => 6,
    },
    9 => {
        name => "Veterans Day",
        date => "0000-11-11", # month and day of the armistice ending WW I fighting  
        date-observed => "",
        short-name => "",
        id => 9,
    },
    11 => {
        name => "Christmas Day",
        date => "0000-12-31",   
        date-observed => "", 
        short-name => "",
        id => 11,
    },

    # calculated actual and observed date
    2 => {
        name => "Birthday of Martin Luther King, Jr.",
        date => "", # third Monday of January
        date-observed => "", 
        short-name => "",
        id => 2,
    },
    3 => {
        name => "Washington's Birthday",
        date => "", # third Monday of February
        date-observed => "",
        short-name => "",
        id => 3,
    },
    4 => {
        name => "Memorial Day",
        date => "", # last Monday in May
        date-observed => "",
        short-name => "",
        id => 4,
    },
    7 => {
        name => "Labor Day",
        date => "", # first Monday in September 
        date-observed => "", 
        short-name => "",
        id => 7,
    },
    8 => {
        name => "Columbus Day",
        date => "", # second Monday in October 
        date-observed => "",
        short-name => "",
        id => 8,
    },
    10 => {
        name => "Thanksgiving Day",
        date => "", # fourth Thursday in November
        date-observed => "",
        short-name => "",
        id => 10,
    },
];

sub get-holidays(:$year!, :$debug --> List) is export {
    my @h;
    for %fedholidays -> $id {
        my FedHoliday $h = calc-holiday-dates :$year, :$id, :$debug;
        @h.push: $h;
    }
    @h
}

# Routines for calculating dates observed for federal holidays:
# There are two types:
#   1. Those holidays designated as a certain day of the month.
#   2. Those holidays with assigned dates that may fall on
#      weekends. When the date for a year falls on a Saturday,
#      it is observed on the previous Friday. When the date falls
#      on a Sunday, it is observed on the following Monday.

sub calc-holiday-dates(:$year!, :$id!, :$debug --> FedHoliday) is export {
    # FedHolidays with attribute date => "0000-nn-nn" are subject to the weekend
    # rule and have two dates: actual and observed (which are the same
    # if the actual date is NOT on a weekend).
    #
    # FedHolidays with attribute date => "" (empty) are subject to the 
    # directed or calculated rule and their actual and observed dates
    # are the same.

    my $name          = %fedholidays{$id}<name>;
    my $date          = %fedholidays{$id}<date>;
    my $date-observed = %fedholidays{$id}<date-observed>;
    my $short-name    = %fedholidays{$id}<short-name>;
    my $check-id      = %fedholidays{$id}<id>;

    if $date ~~ /^ '0000-' (\S\S) '-' (\S\S) / {
        my $month = ~$0;
        my $day   = ~$1;
        # the actual date
        $date = Date.new("$year-$month-$day");    
        # check if it's on a weekend
        my $dow = $date.day-of-week; # 1..7 Mon..Sun
        if $dow == 6 {
            # use previous day (Friday)
            $date-observed = $date.pred;
        }
        elsif $dow == 7 {
            # use next day (Monday)
            $date-observed = $date.succ;
        }
        else {
            $date-observed = $date;
        }
    }
    else {
        # date and observed are the same and must be calculated
        $date = calc-date :$name, :$year, :$debug; 
        $date-observed = $date;
    }
    FedHoliday.new: :$date, :$date-observed, :$id, :$name, :$short-name;
}

sub calc-date(:$name!, :$year!, :$debug --> Date) is export {
    my Date $date;
    with $name {
        my ($month, $nth, $dow);
        when $_.contains("Martin") {
            # Birthday of Martin Luther King, Jr. 
            # third Monday of January
            $month = 1;
            $dow   = 1;
            $nth   = 3;
            $date  = nth-day-of-week-in-month :$year, :$month, 
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Washington") {
            # Washington's Birthday               
            # third Monday of February
            $month    = 2;
            $dow   = 1;
            $nth   = 3;
            $date  = nth-day-of-week-in-month :$year, :$month, 
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Memorial") {
            # Memorial Day                        
            # last Monday in May
            $dow   = 1;
            $nth   = -1;
            $month = 5;
            $date  = nth-day-of-week-in-month :$year, :$month, 
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Labor") {
            # Labor Day                           
            # first Monday in September 
            $dow   = 1;
            $month = 9;
            $nth   = 1;
            $date  = nth-day-of-week-in-month :$year, :$month, 
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Columbus") {
            # Columbus Day                        
            # second Monday in October 
            $dow   = 1;
            $month = 10;
            $nth   = 2;
            $date  = nth-day-of-week-in-month :$year, :$month, 
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Thanksgiving") {
            # Thanksgiving Day                    
            # fourth Thursday in November
            $dow   = 4;
            $month = 11;
            $nth   = 4;
            $date  = nth-day-of-week-in-month :$year, :$month, 
                     :day-of-week($dow), :$nth, :$debug;
        }
        default {
            die "FATAL: Unknown holiday '$name'";
        }
    }
    $date
}

