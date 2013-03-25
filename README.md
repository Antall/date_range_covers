# DateRangeCovers

Library to return months/weeks/days covered by a date range

## Installation

Add this line to your application's Gemfile:

    gem 'date_range_covers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_range_covers

## Usage

    require 'date_range_covers'

    start_date = Date.parse('2013-01-01')
    end_date = Date.parse('2013-04-11')
    start_of_week = :sunday #or :monday

    d = DateRangeCovers::DateRange.new(start_date, end_date, start_of_week)

    d.covers #the date range partitioned into months, weeks and days
    => {
      :days=>[
        Mon, 01 Apr 2013, Tue, 02 Apr 2013, Wed, 03 Apr 2013, Thu, 04 Apr 2013, 
        Fri, 05 Apr 2013, Sat, 06 Apr 2013, Sun, 07 Apr 2013, Mon, 08 Apr 2013,
        Tue, 09 Apr 2013, Wed, 10 Apr 2013, Thu, 11 Apr 2013
      ], 
      :months=>[Tue, 01 Jan 2013, Fri, 01 Feb 2013, Fri, 01 Mar 2013], 
      :weeks=>[]
    }

    params = [:days] #all dates within the date range   
    d.covers params

    params = [:weeks] #the days in the date range partitioned into weeks/days
    d.covers params

    params = [:months] #days in the date range partitioned into months/days
    d.covers params
    
    params = [:days, :weeks] #same as [:weeks]
    d.covers params

    params = [:days, :months] #same as [:months]
    d.covers params
    
    params = [:weeks, :months] #same as [:all]
    d.covers params


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
