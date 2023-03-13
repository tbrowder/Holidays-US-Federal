use Test;
use Holidays::US::Federal;

# YEAR: 2023

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

my $year = 2023;
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
    #note "DEBUG id : $id";

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
    die "FATAL: \$id '$id' is an Int!!" if $id ~~ Int;
    with $id {
        when /^:i new/ {
            # new years day
            # traditional
            is $date, $d;
            is $date+1, $do;
        }
        when /^:i mlk/ {
            # mlk
            is $date, $d;
            is $date, $do;
        }
        when /^:i gwb/ {
            # gw bday
            is $date, $d;
            is $date, $do;
        }
        when /^:i mem/ {
            # memorial day
            is $date, $d;
            is $date, $do;
        }
        when /^:i june/ {
            # juneteenth
            # traditional
            is $date, $d;
            is $date, $do;
        }
        when /^:i jul4/ {
            # independence day
            # traditional
            is $date, $d;
            is $date, $do;
        }
        when /^:i lab/ {
            # labor day
            is $date, $d;
            is $date, $do;
        }
        when /^:i col/ {
            # columbus day
            is $date, $d;
            is $date, $do;
        }
        when /^:i vet/ {
            # veterans day
            # traditional
            is $date, $d;
            is $date-1, $do;
        }
        when /^:i thank/ {
            # thanksgiving
            is $date, $d;
            is $date, $do;
        }
        when /^:i christ/ {
            # christmas day
            # traditional
            is $date, $d;
            is $date, $do;
        }
        default {
            die "FATAL: Unexpected 'when' \$_: '$_'";
        }
    }
}

done-testing;
