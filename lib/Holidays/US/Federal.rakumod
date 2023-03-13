unit module Holidays::US::Federal;

use Date::Utils;
use Date::Event;

class FedHoliday is Date::Event {};

# 11 federal holidays as legislated in 5 U.S. Code S 6103
#    names are as specified in that law
# the 'short-name' values are not official but are the ones
# used by the author in his calendars
our %fedholidays is export = [
    new => {
        name => "New Year's Day",
        date => "0000-01-01",
        date-observed => "",
        short-name => "New Years Day",
        id => 'new',
    },
    june => {
        name => "Juneteenth National Independence Day",
        date => "0000-06-19",
        date-observed => "",
        short-name => "Juneteenth",
        id => 'june',
    },
    jul4 => {
        name => "Independence Day",
        date => "0000-07-04",
        date-observed => "Independence Day",
        short-name => "",
        id => 'jul4',
    },
    vets => {
        name => "Veterans Day",
        date => "0000-11-11", # month and day of the armistice ending WW I fighting
        date-observed => "",
        short-name => "Veterans Day",
        id => 'vets',
    },
    christ => {
        name => "Christmas Day",
        date => "0000-12-25",
        date-observed => "",
        short-name => "Christmas Day",
        id => 'christ',
    },

    # calculated actual and observed date
    mlk => {
        name => "Birthday of Martin Luther King, Jr.",
        date => "", # third Monday of January
        date-observed => "",
        short-name => "MLK Day",
        id => 'mlk',
    },
    gwb => {
        name => "Washington's Birthday",
        date => "", # third Monday of February
        date-observed => "",
        short-name => "GW Birthday",
        id => 'gwb',
    },
    memorial => {
        name => "Memorial Day",
        date => "", # last Monday in May
        date-observed => "",
        short-name => "Memorial Day",
        id => 'memorial',
    },
    labor => {
        name => "Labor Day",
        date => "", # first Monday in September
        date-observed => "",
        short-name => "Labor Day",
        id => 'labor',
    },
    colum => {
        name => "Columbus Day",
        date => "", # second Monday in October
        date-observed => "",
        short-name => "Columbus Day",
        id => 'colum',
    },
    thanks => {
        name => "Thanksgiving Day",
        date => "", # fourth Thursday in November
        date-observed => "",
        short-name => "Thanksgiving",
        id => 'thanks',
    },
];

sub get-fedholidays(:$year!, :$debug --> Hash) is export {
    my %h;
    for %fedholidays.keys -> $id {
        my FedHoliday $h = calc-holiday-dates :$year, :$id, :$debug;
        %h{$h.date}          = $h;
    }
    %h
}

# Routines for calculating dates observed for US federal holidays:
# There are two types:
#   1. Those holidays designated as a certain day of the month.
#   2. Those holidays with assigned dates that may fall on
#      weekends. When the date for a year falls on a Saturday,
#      it is observed on the previous Friday. When the date falls
#      on a Sunday, it is observed on the following Monday.

sub calc-holiday-dates(:$year!, :$id!, :$debug --> FedHoliday) is export {
    # FedHolidays defined in the %fedholidays hash with attribute date => "0000-nn-nn" are subject to the weekend
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

    # directed date
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
        # calculated date:
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
            $month = 2;
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
