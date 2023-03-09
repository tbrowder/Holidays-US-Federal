unit module Holidays::US::Federal;

# 11 federal holidays as legislated in 5 U.S. Code S 6103
#    names are as specified in that law
our %holidays is export = [
    1 => {
        name => "New Year's Day",
        date => "0000-01-01",
        date-observed => "", 
        short-name => "",
        key => 1,
    },
    5 => {
        name => "Juneteenth National Independence Day",
        date => "0000-06-19", 
        date-observed => "", 
        short-name => "",
        key => 5,
    },
    6 => {
        name => "Independence Day",
        date => "0000-07-04", 
        date-observed => "",
        short-name => "",
        key => 6,
    },
    9 => {
        name => "Veterans Day",
        date => "0000-11-11", # month and day of the armistice ending WW I fighting  
        date-observed => "",
        short-name => "",
        key => 9,
    },
    11 => {
        name => "Christmas Day",
        date => "0000-12-31",   
        date-observed => "", 
        short-name => "",
        key => 11,
    },

    # calculated actual and observed date
    2 => {
        name => "Birthday of Martin Luther King, Jr.",
        date => "", # third Monday of January
        date-observed => "", 
        short-name => "",
        key => 2,
    },
    3 => {
        name => "Washington's Birthday",
        date => "", # third Monday of February
        date-observed => "",
        short-name => "",
        key => 3,
    },
    4 => {
        name => "Memorial Day",
        date => "", # last Monday in May
        date-observed => "",
        short-name => "",
        key => 4,
    },
    7 => {
        name => "Labor Day",
        date => "", # first Monday in September 
        date-observed => "", 
        short-name => "",
        key => 7,
    },
    8 => {
        name => "Columbus Day",
        date => "", # second Monday in October 
        date-observed => "",
        short-name => "",
        key => 8,
    },
    10 => {
        name => "Thanksgiving Day",
        date => "", # fourth Thursday in November
        date-observed => "",
        short-name => "",
        key => 10,
    },
];

# Routines for calculating dates observed for federal holidays:
# There are two types:
#   1. Those holidays designated as a certain day of the month.
#   2. Those holidays with assigned dates that may fall on
#      weekends. When the date for a year falls on a Saturday,
#      it is observed on the previous Friday. When the date falls
#      on a Sunday, it is observed on the following Monday.

sub get-observed-date(:$year!, :$key!, :%holidays!, :$debug --> Date) is export {
    # Holidays with attribute date => "0000-nn-nn" are subject to the weekend
    # rule and have two dates: actual and observed (which are the same
    # if the actual date is NOT on a weekend).
    #
    # Holidays with attribute date => "" (empty) are subject to the 
    # directed or calculated rule and their actual and observed dates
    # are the same.

    my $name          = %holidays{$key}<name>;
    my $date          = %holidays{$key}<date>;
    my $date-observed = %holidays{$key}<date-observed>;
    my $short-name    = %holidays{$key}<short-name>;
    my $check-key     = %holidays{$key}<key>;

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
        calc-date :$name, :$year, :$debug; 
    }
}

sub calc-date(:$name!, :$year!, :$debug --> Date) is export {
    my Date $date;

    with $name {
        my ($month, $day);
        when $_.contains("Martin") {
            # Birthday of Martin Luther King, Jr. 
            # third Monday of January
            $month = 1;
            $date = Date.new: :$year, :$month;
            my $d = $date.day-of-week; # 1..7 Mon..Sun 

            my $w = $date.weekday-of-month; # 
        }
        when $_.contains("Washington") {
            # Washington's Birthday               
            # third Monday of February
            $month = 2;
            $date = Date.new: :$year, :$month;
        }
        when $_.contains("Memorial") {
            # Memorial Day                        
            # last Monday in May
            $month = 5;
            $date = Date.new: :$year, :$month;
        }
        when $_.contains("Labor") {
            # Labor Day                           
            # first Monday in September 
            $month = 9;
            $date = Date.new: :$year, :$month;
        }
        when $_.contains("Columbus") {
            # Columbus Day                        
            # second Monday in October 
            $month = 10;
            $date = Date.new: :$year, :$month;
        }
        when $_.contains("Thanksgiving") {
            # Thanksgiving Day                    
            # fourth Thursday in November
            $month = 11;
            $date = Date.new: :$year, :$month;
        }
        default {
            die "FATAL: Unknown holiday '$name'";
        }
    }
    $date
}

sub date-of-monday(:$year!, :$month!, UInt :$cardinal!, :$debug --> Date) is export {
    # Returns the date of the cardinal number of Mondays
    my Date $date .= new: :$year, :$month;
    my $dow = $date.day-of-week; # 1..7 Mon..Sun 
    my $d = $date;
    # get the first Monday
    if $dow > 1 {
        # days until Monday
        my $nd = 8 - $dow;
        $d += $nd; 
    }
    # get the $cardinal Monday
    my $nd = 7 * ($cardinal - 1);
    $d += $nd; 
}

sub date-of-thursday(:$year!, :$month!, :$cardinal!, :$debug --> Date) is export {
    # Returns the date of the cardinal number of Thursdays
    my Date $date .= new: :$year, :$month;
    my $dow = $date.day-of-week; # 1..7 Mon..Sun 
    my $d = $date;
    # get the first Thursday (dow 4)
    die "Tom, fix this";
    if $dow > 4 {
        # days until Thursday
        my $nd = 8 - $dow;
        $d += $nd; 
    }
    elsif $dow < 4 {
    }
    # get the $cardinal Thursday
    my $nd = 7 * ($cardinal - 1);
    $d += $nd; 
}

