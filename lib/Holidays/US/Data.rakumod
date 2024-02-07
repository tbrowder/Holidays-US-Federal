unit module Holidays::US::Data;

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
        date-observed => "",
        short-name => "4th of July",
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
        short-name => "Christmas",
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
