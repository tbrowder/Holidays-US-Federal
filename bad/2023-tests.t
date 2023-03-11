use Test;
use Holidays::US::Federal;

# YEAR: 2023

# holiday keys:
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
my @d = %h.keys.sort({$^a cmp $^b});
for @d -> $D {
    my Date $date .= new: $D;
    my $h  = %h{$date};
    my $d  = $h.date;
    my $do = $h.date-observed;
    my $n  = $h.name;
    my $ns = $h.short-name;

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
}

done-testing;
