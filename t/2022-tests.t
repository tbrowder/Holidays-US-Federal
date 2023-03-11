use Test;
use Holidays::US::Federal;

# YEAR: 2022

# holidays: id and name:
#   1 New Year's Day
#   2 Martin Luther King's Birthday
#   3 George Washington's Birthday
#   4 Memorial Day
#   5 Juneteenth National Independence Day
#   6 Independence Day
#   7 Labor Day
#   8 Columbus Day
#   9 Veterans Day
#  10 Thanksgiving
#  11 Christmas

my $year = 2022;
my %h = get-fedholidays :$year;
# keys are the traditional dates
my @d = %h.keys.sort({$^a cmp $^b});
for @d -> $D {
    my Date $date .= new: $D;
    #note "DEBUG: $date";
    my $h  = %h{$date};
    my $d  = $h.date;
    my $do = $h.date-observed;
    my $n  = $h.name;
    my $ns = $h.short-name;
    my $id = $h.id;

    my $show-on-cal;
    if $d == $do {
        # traditional and observed
        # show traditional name on calendar
        $show-on-cal = $ns;
    }
    elsif $date == $d {
        # traditional
        # show traditional name on calendar
        $show-on-cal = $ns;
    }
    elsif $date == $do {
        # observed
        # show "Fed. Holiday" on calendar
    }

    # tests
    with $id {
        when /^1$/ {
            # new years day
            # traditional
            is $date, $d;
            is $date-1, $do;
        }
        when /2/ { 
            # mlk 
            is $date, $d;
            is $date, $do;
        }
        when /3/ {
            # gw bday
            is $date, $d;
            is $date, $do;
        }
        when /4/ {
            # memorial day
            is $date, $d;
            is $date, $do;
        }
        when /5/ {
            # juneteenth
            # traditional
            is $date, $d;
            is $date+1, $do;
        }
        when /6/ {
            # independence day
            # traditional
            is $date, $d;
            is $date, $do;
        }
        when /7/ {
            # labor day
            is $date, $d;
            is $date, $do;
        }
        when /8/ {
            # columbus day
            is $date, $d;
            is $date, $do;
        }
        when /9/ {
            # veterans day
            # traditional
            is $date, $d;
            is $date, $do;
        }
        when /10/ {
            # thanksgiving
            is $date, $d;
            is $date, $do;
        }
        when /11/ {
            # christmas day
            # traditional
            is $date, $d;
            is $date+1, $do;
        }
    }
}

done-testing;
