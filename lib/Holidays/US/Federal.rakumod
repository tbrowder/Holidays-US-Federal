unit module Holidays::US::Federal;

use Date::Utils;
use Date::Event;
use Holidays::US::Data;

# The class is instantiated when defined in routine 'calc-holiday-dates'.
class FedHoliday is Date::Event {}

sub get-fedholidays(:$year!, :$set-id!, :$debug --> Hash) is export {
    my %h;
    for %fedholidays.keys -> $id {
        my FedHoliday $h = calc-holiday-dates :$year, :$id, :$debug;
        my $key = $set-id ~ '|' ~ $id;
        %h{$h.date}{$key} = $h;
    }
    %h
}

# Routines for calculating dates observed for US federal holidays:
# There are two types:
#   1. Those holidays designated as being on a certain day of the month.
#   2. Those holidays with assigned dates that may fall on
#      weekends. When the date for a year falls on a Saturday,
#      it is observed on the previous Friday. When the date falls
#      on a Sunday, it is observed on the following Monday.

sub calc-holiday-dates(:$year!, :$id!, :$debug --> FedHoliday) { # is export {
    # FedHolidays defined in the %fedholidays hash with attribute
    # date => "0000-nn-nn" are subject to the weekend rule and
    # have two dates: actual and observed (which are the same if the
    # actual date is NOT on a weekend).
    #
    # FedHolidays with attribute date => "" (empty) are subject to the
    # directed or calculated rule and their actual and observed dates
    # are the same.

    my $name          = %fedholidays{$id}<name>;
    my $date          = %fedholidays{$id}<date>;
    my $date-observed = %fedholidays{$id}<date-observed>;
    my $short-name    = %fedholidays{$id}<short-name>;
    my $check-id      = %fedholidays{$id}<id>;

    # directed date (subject to the weekend rule)
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
    FedHoliday.new: :Etype(100), :$date, :$date-observed, :$id, :$name, :$short-name;
}

sub calc-date(:$name!, :$year!, :$debug --> Date) { # is export {
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
