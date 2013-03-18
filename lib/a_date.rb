module ADate

  @@DAYS_OF_WEEK = [
    :sunday, 
    :monday,
    :tuesday,
    :wednesday,
    :thursday,
    :friday,
    :saturday
  ]

  def self.beginning_of_week(date, beginning_of_week_day = :sunday)
    beginning_of_week_adj = @@DAYS_OF_WEEK.index beginning_of_week_day
   
    current_day_number = 0
    current_day_number = date.wday if date.wday != 0
    current_day_number = 7 if date.wday == 0 and beginning_of_week_adj == 1
    
    date = date - current_day_number + beginning_of_week_adj
  end

  def self.end_of_week(date, beginning_of_week_day = :sunday)
    beginning_of_week(date, beginning_of_week_day) + 6
  end
end
