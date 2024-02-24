use Test;
use Holidays::US::Federal;

# YEAR: 2027

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

my $year = 2027;

my %h = get-fedholidays-hashlist :$year;
for %h.keys -> $D {
    my $date = Date.new: $D;
    for @(%h{$date}) -> $h {
        isa-ok $h, Date::Event;

        my Date $d  = $h.date;
        my $do = $h.date-observed;
        my $n  = $h.name;
        my $ns = $h.short-name;
        my $id = $h.id;
        is $h.etype(100), "Holiday", "EType is 100 (holiday)";
        is $h.etype, "Holiday", "EType is 100 (holiday)";

        my $show-on-cal;
        if $d eq $do {
            # traditional and observed
            # show traditional name on calendar
            $show-on-cal = $ns;
        }
        elsif $date eq $d {
            # traditional
            # show traditional name on calendar
            $show-on-cal = $ns;
        }
        elsif $date eq $do {
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
                is $date, $do;
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
                is $date-1, $do;
            }
            when /^:i jul4/ {
                # independence day
                # traditional
                is $date, $d;
                is $date+1, $do;
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
                is $date, $do;
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
                is $date-1, $do;
            }
            default {
                die "FATAL: Unexpected 'when' \$_: '$_'";
            }
        }
    } # end of the Date array loop
}

done-testing;
