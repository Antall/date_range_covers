require 'lib/date_range_covers'

describe DateRangeCovers do
  describe "#is_single_date_range?" do
    context 'when same start and end dates are passed' do
      it 'should return true' do
        date = Date.today
        drange = DateRangeCovers::DateRange.new(date, date)
        drange.is_single_date_range?.should == true
      end
    end

    context 'when same start and end dates are passed and either are nil' do
      it 'should return true' do
        date = nil
        drange = DateRangeCovers::DateRange.new(date, date)
        drange.is_single_date_range?.should == false
      end
    end
 
    context 'when different start and end dates are passed' do
      it 'should return false' do
        date = Date.today
        drange = DateRangeCovers::DateRange.new(date, date + 1)
        drange.is_single_date_range?.should == false
      end
    end
  end
 
  describe "#is_date_range?" do
    context 'when same start and end dates are passed' do
      it 'should return false' do
        date = Date.today
        drange = DateRangeCovers::DateRange.new(date, date)
        drange.is_date_range?.should == false
      end
    end

    context 'when diff start and end dates are passed and either are nil' do
      it 'should return false' do
        date = nil
        drange = DateRangeCovers::DateRange.new(date, date)
        drange.is_date_range?.should == false
      end
    end
 
    context 'when different start and end dates are passed' do
      it 'should return true' do
        date = Date.today
        drange = DateRangeCovers::DateRange.new(date, date + 1)
        drange.is_date_range?.should == true
      end
    end
  end

  describe "#months_covered" do
    context 'when dates are in the same month' do
      let(:date) { Date.today }
      let(:drange) { DateRangeCovers::DateRange.new(date, date, :sunday) }
        
      context 'when include is nil' do
        let(:months) { drange.months_covered }
        it 'should return no months' do
          months.should be_empty
        end
      end
 
      context 'when include is start_month' do
        let(:months) { drange.months_covered(:include => :start_month) }
        it 'should return start months' do
          months.should_not be_empty
          months.should include date.beginning_of_month
        end
      end
 
      context 'when include is end_month' do
        let(:months) { drange.months_covered(:include => :end_month) }
        it 'should return end months' do
          months.should_not be_empty
          months.should include date.beginning_of_month
        end
      end
 
      context 'when include is both' do
        let(:months) { drange.months_covered(:include => :both) }
        it 'should return start months' do
          months.should_not be_empty
          months.should include date.beginning_of_month
        end
      end
    end

    context 'when dates are not the same' do
      context '2013-03-01 to 2013-03-31' do
        let(:start_date) { Date.parse('2013-03-01') }
        let(:end_date) { Date.parse('2013-03-31') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
        context 'when include is nil' do
          let(:months) { drange.months_covered }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
 
        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
 
        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
       
        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
      end

      context '2013-03-01 to 2013-03-30' do
        let(:start_date) { Date.parse('2013-03-01') }
        let(:end_date) { Date.parse('2013-03-30') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
        context 'when include is nil' do
          let(:months) { drange.months_covered }
          it 'should return no months' do
            months.should be_empty
          end
        end
 
        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
 
        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
       
        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
      end
      
      context '2013-02-15 to 2013-03-15' do
        let(:start_date) { Date.parse('2013-02-15') }
        let(:end_date) { Date.parse('2013-03-15') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
        context 'when include is nil' do
          let(:months) { drange.months_covered }
          it 'should return no months' do
            months.should be_empty
          end
        end
 
        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include start_date.beginning_of_month
          end
        end
 
        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            months.should_not be_empty
            months.should include end_date.beginning_of_month
          end
        end
       
        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            months.length.should == 2
            months.should include start_date.beginning_of_month
            months.should include end_date.beginning_of_month
          end
        end
      end
      
      context '2013-02-15 to 2013-04-15' do
        let(:start_date) { Date.parse('2013-02-15') }
        let(:end_date) { Date.parse('2013-04-15') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
        context 'when include is nil' do
          let(:months) { drange.months_covered }
          it 'should return no months' do
            months.length.should == 1
            months.should include Date.parse('2013-03-01')
          end
        end
 
        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            months.length.should == 2
            months.should include start_date.beginning_of_month
            months.should include Date.parse('2013-03-01')
          end
        end
 
        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            months.length.should == 2
            months.should include end_date.beginning_of_month
            months.should include Date.parse('2013-03-01')
          end
        end
       
        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            months.length.should == 3
            months.should include start_date.beginning_of_month
            months.should include end_date.beginning_of_month
            months.should include Date.parse('2013-03-01')
          end
        end
      end

      context '2013-02-01 to 2013-04-15' do
        let(:start_date) { Date.parse('2013-02-01') }
        let(:end_date) { Date.parse('2013-04-15') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
        context 'when include is nil' do
          let(:months) { drange.months_covered }
          it 'should return no months' do
            months.length.should == 2
            months.should include Date.parse('2013-03-01')
            months.should include start_date.beginning_of_month
          end
        end
 
        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            months.length.should == 2
            months.should include start_date.beginning_of_month
            months.should include Date.parse('2013-03-01')
          end
        end
 
        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            months.length.should == 3
            months.should include end_date.beginning_of_month
            months.should include start_date.beginning_of_month
            months.should include Date.parse('2013-03-01')
          end
        end
       
        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            months.length.should == 3
            months.should include start_date.beginning_of_month
            months.should include end_date.beginning_of_month
            months.should include Date.parse('2013-03-01')
          end
        end
      end
    end
  end

  describe "#covers" do
    context 'date range split across four months' do
      let(:start_date) { Date.parse('2013-03-06') }
      let(:end_date) { Date.parse('2013-06-22') }
      let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
      context 'when include is :all' do
        let(:covers) { drange.covers }
        it "should return with just the days between" do
          covers[:months].length.should == 2
          (4..5).each do |month|
            covers[:months].should include Date.parse("2013-#{month}-01")
          end
          
          covers[:weeks].length.should == 6
          %w(2013-03-10 2013-03-17 2013-03-24 2013-06-02 2013-06-09 2013-06-16).each do |date|
            covers[:weeks].should include Date.parse(date)
          end
         
          covers[:dates].length.should == 6
          %w(2013-03-06 2013-03-07 2013-03-08 2013-03-09 2013-03-31 2013-06-01).each do |date|
            covers[:dates].should include Date.parse(date)
          end
        end
      end
 
      context 'when include is :months' do
        let(:covers) { drange.covers([:months]) }
        it "should return with just the days between" do
          covers[:months].length.should == 2
          (4..5).each do |month|
            covers[:months].should include Date.parse("2013-#{month}-01")
          end

          covers[:weeks].should be_nil

          covers[:dates].length.should == 48
          (6..31).each do |day|
            covers[:dates].should include Date.parse("2013-03-#{day}")
          end
          (1..22).each do |day|
            covers[:dates].should include Date.parse("2013-06-#{day}")
          end
        end
      end
 
      context 'when include is :weeks' do
        let(:covers) { drange.covers([:weeks]) }
        it "should return with just the weeks and dates" do
          covers[:months].should be_nil
          covers[:weeks].length.should == 15 
          covers[:dates].length.should == 4 
        end
      end
  
      context 'when include is :dates' do
        let(:covers) { drange.covers([:dates]) }
        it "should return with just the days between" do
          covers[:months].should be_nil
          covers[:weeks].should be_nil
          covers[:dates].length.should == (start_date..end_date).collect {|date| date}.length
          (start_date..end_date).each do |date|
            covers[:dates].should include date
          end
        end
      end
    end

   context 'date range split across three weeks' do
      let(:start_date) { Date.parse('2013-03-06') }
      let(:end_date) { Date.parse('2013-03-22') }
      let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
      context 'when include is :all' do
        let(:covers) { drange.covers }
        it "should return with just the days between" do
          covers[:months].should be_empty
          covers[:weeks].length.should == 1
          covers[:weeks].should include Date.parse('2013-03-10')
          covers[:dates].length.should == 10
          (Date.parse('2013-03-06')..Date.parse('2013-03-09')).each do |date|
            covers[:dates].should include date
          end
          (Date.parse('2013-03-17')..Date.parse('2013-03-22')).each do |date|
            covers[:dates].should include date
          end
        end
      end
 
      context 'when include is :months' do
        let(:covers) { drange.covers([:months]) }
        it "should return with just the days between" do
          covers[:months].should be_empty
          covers[:weeks].should be_nil
          covers[:dates].length.should == 17 
          (start_date..end_date).each do |date|
            covers[:dates].should include date
          end
        end
      end
 
      context 'when include is :weeks' do
        let(:covers) { drange.covers([:weeks]) }
        it "should return with just the days between" do
          covers[:months].should be_nil
          covers[:weeks].length.should == 1
          covers[:weeks].should include Date.parse('2013-03-10')
          covers[:dates].length.should == 10
          (Date.parse('2013-03-06')..Date.parse('2013-03-09')).each do |date|
            covers[:dates].should include date
          end
          (Date.parse('2013-03-17')..Date.parse('2013-03-22')).each do |date|
            covers[:dates].should include date
          end
        end
      end
  
      context 'when include is :dates' do
        let(:covers) { drange.covers([:dates]) }
        it "should return with just the days between" do
          covers[:months].should be_nil
          covers[:weeks].should be_nil
          covers[:dates].length.should == 17 
          (start_date..end_date).each do |date|
            covers[:dates].should include date
          end
        end
      end
    end

    context 'date range split across two weeks' do
      let(:start_date) { Date.parse('2013-03-06') }
      let(:end_date) { Date.parse('2013-03-15') }
      let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
 
      context 'when include is :all' do
        let(:covers) { drange.covers }
        it "should return with just the days between" do
          covers[:months].should be_empty
          covers[:weeks].should be_empty
          covers[:dates].should_not be_empty
          (start_date..end_date).each do |date|
            covers[:dates].should include date
          end
        end
      end
 
      context 'when include is :months' do
        let(:covers) { drange.covers([:months]) }
        it "should return with just the days between" do
          covers[:months].should be_empty
          covers[:weeks].should be_nil
          covers[:dates].should_not be_empty
          (start_date..end_date).each do |date|
            covers[:dates].should include date
          end
        end
      end
 
      context 'when include is :weeks' do
        let(:covers) { drange.covers([:weeks]) }
        it "should return with just the days between" do
          covers[:months].should be_nil
          covers[:weeks].should be_empty
          covers[:dates].should_not be_empty
          (start_date..end_date).each do |date|
            covers[:dates].should include date
          end
        end
      end
  
      context 'when include is :dates' do
        let(:covers) { drange.covers([:dates]) }
        it "should return with just the days between" do
          covers[:months].should be_nil
          covers[:weeks].should be_nil
          covers[:dates].should_not be_empty
          (start_date..end_date).each do |date|
            covers[:dates].should include date
          end
        end
      end
    end
  end

  describe "#weeks_covered" do
    context "when dates in the same week" do
      context 'when dates are the same' do
        let(:date) { Date.today }
        let(:drange) { DateRangeCovers::DateRange.new(date, date, :sunday) }
       
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return no weeks' do
            weeks.should be_empty
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return week containing the start date' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(date)
          end
        end
 
        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return week containing the end date' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(date)
          end
        end
 
        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return weeks containing the start date and the end date' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(date)
          end
        end
     end
    end

    context "when dates are in different weeks" do
      context '2013-03-02(Saturday) to 2013-03-03(Sunday)' do 
        let(:start_date) { Date.parse('2013-03-02') }
        let(:end_date) { Date.parse('2013-03-03') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
        
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return no weeks' do
            weeks.should be_empty
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(start_date)
          end
        end
 
        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(end_date)
          end
        end
 
        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(end_date)
            weeks.should include ADate.beginning_of_week(start_date)
          end
        end
      end
      
      context '2013-03-03(Sunday) to 2013-03-09(Saturday)' do 
        let(:start_date) { Date.parse('2013-03-03') }
        let(:end_date) { Date.parse('2013-03-09') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return week with 2013-03-03 as the date' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(start_date)
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(start_date)
          end
        end
 
        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(end_date)
          end
        end
 
        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(end_date)
            weeks.should include ADate.beginning_of_week(start_date)
          end
        end
      end

      context '2013-03-03(Sunday) to 2013-03-10(Sunday)' do 
        let(:start_date) { Date.parse('2013-03-03') }
        let(:end_date) { Date.parse('2013-03-10') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return week with 2013-03-03 as the date' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(start_date)
            weeks.should_not include ADate.beginning_of_week(end_date)
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(start_date)
            weeks.should_not include ADate.beginning_of_week(end_date)
          end
        end
 
        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(end_date)
            weeks.should include ADate.beginning_of_week(start_date)
          end
        end
 
        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            weeks.should_not be_empty
            weeks.should include ADate.beginning_of_week(end_date)
            weeks.should include ADate.beginning_of_week(start_date)
          end
        end
      end

      context '2013-03-05(Tuesday) to 2013-03-31(Sunday)' do 
        let(:start_date) { Date.parse('2013-03-05') }
        let(:end_date) { Date.parse('2013-03-31') }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return weeks of 10, 17 and 24' do
            weeks.length.should == 3
            weeks.should include Date.parse('2013-03-10')
            weeks.should include Date.parse('2013-03-17')
            weeks.should include Date.parse('2013-03-24')
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            weeks.length.should == 4
            weeks.should include ADate.beginning_of_week(start_date)
            weeks.should include Date.parse('2013-03-10')
            weeks.should include Date.parse('2013-03-17')
            weeks.should include Date.parse('2013-03-24')
            weeks.should_not include ADate.beginning_of_week(end_date)
          end
        end
 
        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            weeks.length.should == 4
            weeks.should_not include ADate.beginning_of_week(start_date)
            weeks.should include Date.parse('2013-03-10')
            weeks.should include Date.parse('2013-03-17')
            weeks.should include Date.parse('2013-03-24')
            weeks.should include ADate.beginning_of_week(end_date)
          end
        end
 
        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            weeks.length.should == 5
            weeks.should include ADate.beginning_of_week(start_date)
            weeks.should include Date.parse('2013-03-10')
            weeks.should include Date.parse('2013-03-17')
            weeks.should include Date.parse('2013-03-24')
            weeks.should include ADate.beginning_of_week(end_date)
          end
        end
      end
    end
  end

  describe "#dates_covered" do
    context "when start_date and end_date are the same" do
      let(:date) { Date.today }
      let(:drange) { DateRangeCovers::DateRange.new(date, date, :sunday) }

      context 'when include is nil' do
        let(:dates)  { drange.dates_covered }
        it { dates.should be_empty }
      end
      
      context 'when include is set to :both' do
        let(:dates)  { drange.dates_covered(:include => :both) }
        it { dates.should include date }
      end
 
      context 'when include is set to :start_date' do
        let(:dates)  { drange.dates_covered(:include => :start_date) }
        it { dates.should include date }
      end
      
      context 'when include is set to :end_date' do
        let(:dates)  { drange.dates_covered(:include => :end_date) }
        it { dates.should include date }
      end
    end
    
    context "when start_date and end_date are different" do
      let(:start_date) { Date.today - 1 }
      let(:end_date) { Date.today }
      let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }

      context 'when include is nil' do
        let(:dates)  { drange.dates_covered }
        it { dates.should be_empty }
      end
 
      context 'when include is set to :start_date' do
        let(:dates)  { drange.dates_covered(:include => :start_date) }
        it { dates.length.should == 1 }
        it { dates.should include start_date }
        it { dates.should_not include end_date }
      end
 
      context 'when include is set to :end_date' do
        let(:dates) { drange.dates_covered(:include => :end_date) }
        it { dates.length.should == 1 }
        it { dates.should include end_date }
        it { dates.should_not include start_date }
      end
      
      context 'when include is set to :both' do
        let(:dates) { drange.dates_covered(:include => :both) }
        it { dates.length.should == 2 }
        it { dates.should include end_date }
        it { dates.should include start_date }
      end
    end
    
    context "when start_date and end_date are more than a day apart" do
      let(:start_date) { Date.today - 2 }
      let(:end_date) { Date.today }
      let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }

      context 'when include is nil' do
        let(:dates)  { drange.dates_covered }
        it { dates.length.should == 1 }
        it { dates.should_not include start_date }
        it { dates.should_not include end_date }
      end
 
      context 'when include is set to :start_date' do
        let(:dates)  { drange.dates_covered(:include => :start_date) }
        it { dates.length.should == 2 }
        it { dates.should include start_date }
        it { dates.should_not include end_date }
      end
 
      context 'when include is set to :end_date' do
        let(:dates) { drange.dates_covered(:include => :end_date) }
        it { dates.length.should == 2 }
        it { dates.should include end_date }
        it { dates.should_not include start_date }
      end
      
      context 'when include is set to :both' do
        let(:dates) { drange.dates_covered(:include => :both) }
        it { dates.length.should == 3 }
        it { dates.should include end_date }
        it { dates.should include start_date }
      end
    end
  end
end
