require "date_range_covers/version"
require 'date'
require 'active_support/all'

module DateRangeCovers
  class DateRange
    attr_reader :start_date, :end_date
    attr_reader :beginning_of_week_day
    attr_reader :covs

   def initialize(start_date, end_date, bow_day = :monday)
      @start_date = start_date
      @end_date = end_date
      @beginning_of_week_day = bow_day
      @covs = {}
    end
  
    # Is the date range created, a single date range
    #
    # @example
    #   boolean = DateRangeCovers::DateRange.is_single_date_range?
    #
    # @return boolean
    #   true: when start date and end date are the same
    #   false: when start date and end date are different or either date is nil
    #
    # @api public 
    def is_single_date_range?
      (start_date and end_date and start_date == end_date) ? true : false
    end

    # Is the date range created an actual date range
    #
    # @example
    #   boolean = DateRangeCovers::DateRange.is_date_range?
    #
    # @return boolean
    #   true: when start date and end date are different
    #   false: when start date and end date are the same or either date is nil
    #
    # @api public 
    def is_date_range?
      (start_date and end_date and !is_single_date_range?) ? true : false
    end

    # months_covered
    #
    # @example
    #   months = DateRangeCovers::DateRange.months_covered(options)
    #
    # @options
    #   :include 
    #     => :start_month - include the month containing the start date
    #     => :end_month - include the month containing the end date
    #     => :both - include months containing start date and end date respectively
    #
    # @return [starting date of months]
    #
    # @api public 
    def months_covered(options={})
      s_date = start_date.dup
      e_date = end_date.dup
      
      months = []

      unless options.empty?
        case options[:include]
        when :both
          months << s_date.beginning_of_month
          months << e_date.beginning_of_month
        when :start_month
          months << s_date.beginning_of_month
        when :end_month 
          months << e_date.beginning_of_month
        end
      end

      #We need to iterate through every month and 
      #see if the month is wholly contained in the 
      #date range
      bottom_of_month = s_date.beginning_of_month
      top_of_month = s_date.end_of_month 

      while bottom_of_month < e_date do
        if (s_date..e_date).include?(bottom_of_month..top_of_month) 
          months << bottom_of_month
        end
        bottom_of_month = bottom_of_month.next_month
        top_of_month = bottom_of_month.end_of_month 
      end

      covs[:months] = months.compact.uniq.sort
    end

    # Checks to see if part of a date range lies in a selected month
    #
    # @example
    #   boolean = DateRangeCovers::DateRange.date_range_flows_into_selected_months(start_date_of_range, end_date_of_range)
    #
    # @return boolean
    #
    # @api private 
    def date_range_flows_into_selected_months?(s_date, e_date)
      if covs[:months]
        covs[:months].each do |bottom_of_month|
          top_of_month = bottom_of_month.end_of_month
            
          #first condition :the month contains the start date and not the end date
          #second condition :the month contains the end date and not the start date
          if ((bottom_of_month..top_of_month).include?(s_date) and !(bottom_of_month..top_of_month).include?(e_date)) \
            or ((bottom_of_month..top_of_month).include?(e_date) and !(bottom_of_month..top_of_month).include?(s_date))
              return true #because the range spilled over the month return true
          end
        end
      end
      false
    end

    # weeks_covered
    #
    # @example
    #   weeks = DateRangeCovers::DateRange.weeks_covered(options)
    #
    # @options
    #   :include
    #     => :start_week - include the week containing the start date
    #     => :end_week - include the week containing the end date
    #     => :both - include weeks containing the start date and end date respectively
    #
    # @return [starting date of weeks]
    #
    # @api public 
    def weeks_covered(options={})
      s_date = start_date.dup
      e_date = end_date.dup

      weeks = []

      unless options.empty?
        case options[:include]
        when :both
          s_date = s_date.beginning_of_week(beginning_of_week_day)
          e_date = e_date.end_of_week(beginning_of_week_day)

          start_of_e_week = e_date.beginning_of_week(beginning_of_week_day)

          weeks << s_date unless is_covered?(s_date)         
          weeks << start_of_e_week unless is_covered?(start_of_e_week)         

        when :start_week
          s_date = s_date.beginning_of_week(beginning_of_week_day)
          weeks << s_date unless is_covered?(s_date)

        when :end_week 
          e_date = e_date.end_of_week(beginning_of_week_day)
          start_of_e_week = e_date.beginning_of_week(beginning_of_week_day)
          
          weeks << start_of_e_week unless is_covered?(start_of_e_week)         
        end
      end

      #We need to iterate through every week and 
      #see if the week is wholly contained in the 
      #date range
      bottom_of_week = s_date.beginning_of_week(beginning_of_week_day)
      top_of_week = s_date.end_of_week(beginning_of_week_day)

      while bottom_of_week < e_date do
        if (s_date..e_date).include?(bottom_of_week..top_of_week)\
            and !date_range_flows_into_selected_months?(bottom_of_week, top_of_week) # if part of a week already belongs to a covered month, we should not add that week to the list
          weeks << bottom_of_week unless is_covered?(bottom_of_week)
        end
        bottom_of_week = bottom_of_week.next_week(beginning_of_week_day)
        top_of_week = bottom_of_week.end_of_week(beginning_of_week_day)
      end

      covs[:weeks] = weeks.compact.uniq.sort
    end

    # dates_covered
    #
    # @example
    #   dates = DateRangeCovers::DateRange.dates_covered(options)
    #
    # @options
    #   :include
    #     => :start_date - include the start date
    #     => :end_date - include the end date
    #     => :both - include the start date and end date respectively
    #
    # @return [dates]
    #
    # @api public 
    def dates_covered(options={})
      s_date = start_date.dup
      e_date = end_date.dup
     
      if is_single_date_range?
        dates = handle_single_date_range(s_date, e_date, options)
      else
        dates = handle_date_range(s_date, e_date, options)
      end

      covs[:days] = dates.compact.sort
    end

   def handle_single_date_range(s_date, e_date, options)
      if options.empty?
        s_date += 1
        dates = (s_date...e_date).collect { |date| date unless is_covered?(date) }
      else
        dates = (s_date..e_date).collect { |date| date unless is_covered?(date) }
      end

      return dates
    end

    def handle_date_range(s_date, e_date, options)
      case options[:include]
      when :both
        # do nothing
      when :end_date
        s_date += 1
      when :start_date
        e_date -= 1
      else
        s_date += 1
        e_date -= 1
      end

      return (s_date..e_date).collect { |date| date unless is_covered?(date) }
    end

    # Returns dates within a date range, partitioned in
    # months/weeks/days.
    #
    # Dates that are not boxed by a week or month, are returned as days. 
    #
    # @example
    #   covered_range = DateRangeCovers::DateRange.covers
    #   covered_range = DateRangeCovers::DateRange.covers(params)
    #
    # @params
    #   [:all] or no params => default, the date range partitioned into months, weeks and days
    #   [:days] => all dates within the date range   
    #   [:weeks] => the days in the date range partitioned into weeks/days
    #   [:months] => days in the date range partitioned into months/days
    
    #   [:days, :weeks] => same as [:weeks]
    #   [:days, :months] => same as [:months]
    #   [:weeks, :months] => same as [:all]
    #
    # @return Hash
    #
    # @api public 
    def covers(cover_options = [:all])
      @covs = {}

      if cover_options.include?(:all)
        months_covered
        weeks_covered
        dates_covered(:include => :both)
      else
        months_covered if cover_options.include?(:months)
        weeks_covered if cover_options.include?(:weeks)
        dates_covered(:include => :both)
      end

      return covs
    end

    def is_covered?(dates)
      is_covered = false

      if !is_covered and covs[:months] and !covs[:months].empty?
        start_month = covs[:months].first
        end_month = covs[:months].last.end_of_month
        is_covered = (start_month..end_month).include?(dates) ? true : false
      end

      if !is_covered and covs[:weeks] and !covs[:weeks].empty?
        covs[:weeks].each do |week_date|
          start_week = week_date.beginning_of_week(beginning_of_week_day)
          end_week = week_date.end_of_week(beginning_of_week_day)
          is_covered = (start_week..end_week).include?(dates) ? true : false
          break if is_covered
        end
      end

      is_covered
    end

    private :is_covered?, :date_range_flows_into_selected_months?
    private :handle_single_date_range, :handle_date_range
 
  end
end
