require 'spec_helper'
require 'date_range_covers'

describe DateRangeCovers do
  describe "#is_single_date_range?" do
    let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date) }

    context 'when same start and end dates are passed' do
      let(:start_date) { Date.today }
      let(:end_date) { Date.today }
      it { expect(drange.is_single_date_range?).to be_truthy }
    end

    context 'when same start and end dates are passed and either are nil' do
      let(:start_date) { nil }
      let(:end_date) { nil }
      it { expect(drange.is_single_date_range?).to be_falsey }
    end

    context 'when different start and end dates are passed' do
      let(:start_date) { Date.today }
      let(:end_date) { Date.today + 1 }
      it { expect(drange.is_single_date_range?).to be_falsey }
    end
  end

  describe "#is_date_range?" do
    let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date) }

    context 'when same start and end dates are passed' do
      let(:start_date) { Date.today }
      let(:end_date) { Date.today }
      it { expect(drange.is_date_range?).to be_falsey }
    end

    context 'when diff start and end dates are passed and either are nil' do
      let(:start_date) { nil }
      let(:end_date) { nil }
      it { expect(drange.is_date_range?).to be_falsey }
    end

    context 'when different start and end dates are passed' do
      let(:start_date) { Date.today }
      let(:end_date) { Date.today + 1 }
      it { expect(drange.is_date_range?).to be_truthy }
    end
  end

  describe "#months_covered" do
    context 'when dates are in the same month' do
      let(:date) { Date.today }
      let(:drange) { DateRangeCovers::DateRange.new(date, date, :sunday) }

      context 'when include is nil' do
        let(:months) { drange.months_covered }
        it { expect(months).to be_empty }
      end

      context 'when include is start_month' do
        let(:months) { drange.months_covered(:include => :start_month) }
        it 'should return start months' do
          expect(months).to_not be_empty
          expect(months).to include(date.beginning_of_month)
        end
      end

      context 'when include is end_month' do
        let(:months) { drange.months_covered(:include => :end_month) }
        it 'should return end months' do
          expect(months).to_not be_empty
          expect(months).to include(date.beginning_of_month)
        end
      end

      context 'when include is both' do
        let(:months) { drange.months_covered(:include => :both) }
        it 'should return start months' do
          expect(months).to_not be_empty
          expect(months).to include(date.beginning_of_month)
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
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
          end
        end

        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
          end
        end

        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
          end
        end

        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
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
            expect(months).to be_empty
          end
        end

        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
          end
        end

        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
          end
        end

        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
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
            expect(months).to be_empty
          end
        end

        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include start_date.beginning_of_month
          end
        end

        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            expect(months).to_not be_empty
            expect(months).to include end_date.beginning_of_month
          end
        end

        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            expect(months.length).to eq 2
            expect(months).to include start_date.beginning_of_month
            expect(months).to include end_date.beginning_of_month
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
            expect(months.length).to eq 1
            expect(months).to include Date.parse('2013-03-01')
          end
        end

        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            expect(months.length).to eq 2
            expect(months).to include start_date.beginning_of_month
            expect(months).to include Date.parse('2013-03-01')
          end
        end

        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            expect(months.length).to eq 2
            expect(months).to include end_date.beginning_of_month
            expect(months).to include Date.parse('2013-03-01')
          end
        end

        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            expect(months.length).to eq 3
            expect(months).to include start_date.beginning_of_month
            expect(months).to include end_date.beginning_of_month
            expect(months).to include Date.parse('2013-03-01')
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
            expect(months.length).to eq 2
            expect(months).to include Date.parse('2013-03-01')
            expect(months).to include start_date.beginning_of_month
          end
        end

        context 'when include is start_month' do
          let(:months) { drange.months_covered(:include => :start_month) }
          it 'should return month with current start date' do
            expect(months.length).to eq 2
            expect(months).to include start_date.beginning_of_month
            expect(months).to include Date.parse('2013-03-01')
          end
        end

        context 'when include is end_month' do
          let(:months) { drange.months_covered(:include => :end_month) }
          it 'should return month with current start date' do
            expect(months.length).to eq 3
            expect(months).to include end_date.beginning_of_month
            expect(months).to include start_date.beginning_of_month
            expect(months).to include Date.parse('2013-03-01')
          end
        end

        context 'when include is both' do
          let(:months) { drange.months_covered(:include => :both) }
          it 'should return month with current start date' do
            expect(months.length).to eq 3
            expect(months).to include start_date.beginning_of_month
            expect(months).to include end_date.beginning_of_month
            expect(months).to include Date.parse('2013-03-01')
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
          expect(covers[:months].length).to eq 2
          (4..5).each do |month|
            expect(covers[:months]).to include Date.parse("2013-#{month}-01")
          end

          expect(covers[:weeks].length).to eq 6
          %w(2013-03-10 2013-03-17 2013-03-24 2013-06-02 2013-06-09 2013-06-16).each do |date|
            expect(covers[:weeks]).to include Date.parse(date)
          end

          expect(covers[:days].length).to eq 6
          %w(2013-03-06 2013-03-07 2013-03-08 2013-03-09 2013-03-31 2013-06-01).each do |date|
            expect(covers[:days]).to include Date.parse(date)
          end
        end
      end

      context 'when include is :months' do
        let(:covers) { drange.covers([:months]) }
        it "should return with just the days between" do
          expect(covers[:months].length).to eq 2
          (4..5).each do |month|
            expect(covers[:months]).to include Date.parse("2013-#{month}-01")
          end

          expect(covers[:weeks]).to be_nil

          expect(covers[:days].length).to eq 48
          (6..31).each do |day|
            expect(covers[:days]).to include Date.parse("2013-03-#{day}")
          end
          (1..22).each do |day|
            expect(covers[:days]).to include Date.parse("2013-06-#{day}")
          end
        end
      end

      context 'when include is :weeks' do
        let(:covers) { drange.covers([:weeks]) }
        it "should return with just the weeks and dates" do
          expect(covers[:months]).to be_nil
          expect(covers[:weeks].length).to eq 15
          expect(covers[:days].length).to eq 4
        end
      end

      context 'when include is :dates' do
        let(:covers) { drange.covers([:days]) }
        it "should return with just the days between" do
          expect(covers[:months]).to be_nil
          expect(covers[:weeks]).to be_nil
          expect(covers[:days].length).to eq (start_date..end_date).collect {|date| date}.length
          (start_date..end_date).each do |date|
            expect(covers[:days]).to include date
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
          expect(covers[:months]).to be_empty
          expect(covers[:weeks].length).to eq 1
          expect(covers[:weeks]).to include Date.parse('2013-03-10')
          expect(covers[:days].length).to eq 10
          (Date.parse('2013-03-06')..Date.parse('2013-03-09')).each do |date|
            expect(covers[:days]).to include date
          end
          (Date.parse('2013-03-17')..Date.parse('2013-03-22')).each do |date|
            expect(covers[:days]).to include date
          end
        end
      end

      context 'when include is :months' do
        let(:covers) { drange.covers([:months]) }
        it "should return with just the days between" do
          expect(covers[:months]).to be_empty
          expect(covers[:weeks]).to be_nil
          expect(covers[:days].length).to eq 17
          (start_date..end_date).each do |date|
            expect(covers[:days]).to include date
          end
        end
      end

      context 'when include is :weeks' do
        let(:covers) { drange.covers([:weeks]) }
        it "should return with just the days between" do
          expect(covers[:months]).to be_nil
          expect(covers[:weeks].length).to eq 1
          expect(covers[:weeks]).to include Date.parse('2013-03-10')
          expect(covers[:days].length).to eq 10
          (Date.parse('2013-03-06')..Date.parse('2013-03-09')).each do |date|
            expect(covers[:days]).to include date
          end
          (Date.parse('2013-03-17')..Date.parse('2013-03-22')).each do |date|
            expect(covers[:days]).to include date
          end
        end
      end

      context 'when include is :dates' do
        let(:covers) { drange.covers([:days]) }
        it "should return with just the days between" do
          expect(covers[:months]).to be_nil
          expect(covers[:weeks]).to be_nil
          expect(covers[:days].length).to eq 17
          (start_date..end_date).each do |date|
            expect(covers[:days]).to include date
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
          expect(covers[:months]).to be_empty
          expect(covers[:weeks]).to be_empty
          expect(covers[:days]).to_not be_empty
          (start_date..end_date).each do |date|
            expect(covers[:days]).to include date
          end
        end
      end

      context 'when include is :months' do
        let(:covers) { drange.covers([:months]) }
        it "should return with just the days between" do
          expect(covers[:months]).to be_empty
          expect(covers[:weeks]).to be_nil
          expect(covers[:days]).to_not be_empty
          (start_date..end_date).each do |date|
            expect(covers[:days]).to include date
          end
        end
      end

      context 'when include is :weeks' do
        let(:covers) { drange.covers([:weeks]) }
        it "should return with just the days between" do
          expect(covers[:months]).to be_nil
          expect(covers[:weeks]).to be_empty
          expect(covers[:days]).to_not be_empty
          (start_date..end_date).each do |date|
            expect(covers[:days]).to include date
          end
        end
      end

      context 'when include is :dates' do
        let(:covers) { drange.covers([:days]) }
        it "should return with just the days between" do
          expect(covers[:months]).to be_nil
          expect(covers[:weeks]).to be_nil
          expect(covers[:days]).to_not be_empty
          (start_date..end_date).each do |date|
            expect(covers[:days]).to include date
          end
        end
      end
    end
  end

  describe "#weeks_covered" do
    context "when dates in the same week" do
      context 'when dates are the same' do
        let(:date) { Date.today }
        let(:start_of_week) { :sunday }
        let(:drange) { DateRangeCovers::DateRange.new(date, date, start_of_week) }

        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return no weeks' do
            expect(weeks).to be_empty
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return week containing the start date' do
            expect(weeks).to_not be_empty
            expect(weeks).to include date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return week containing the end date' do
            expect(weeks).to_not be_empty
            expect(weeks).to include date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return weeks containing the start date and the end date' do
            expect(weeks).to_not be_empty
            expect(weeks).to include date.beginning_of_week(start_of_week)
          end
        end
     end
    end

    context "when dates are in different weeks" do
      context '2013-03-02(Saturday) to 2013-03-03(Sunday)' do
        let(:start_date) { Date.parse('2013-03-02') }
        let(:end_date) { Date.parse('2013-03-03') }
        let(:start_of_week) { :sunday }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, start_of_week) }

        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return no weeks' do
            expect(weeks).to be_empty
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
          end
        end
      end

      context '2013-03-03(Sunday) to 2013-03-09(Saturday)' do
        let(:start_date) { Date.parse('2013-03-03') }
        let(:end_date) { Date.parse('2013-03-09') }
        let(:start_of_week) { :sunday }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, start_of_week) }
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return week with 2013-03-03 as the date' do
            expect(weeks).to_not be_empty
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
          end
        end
      end

      context '2013-03-03(Sunday) to 2013-03-10(Sunday)' do
        let(:start_date) { Date.parse('2013-03-03') }
        let(:end_date) { Date.parse('2013-03-10') }
        let(:start_of_week) { :sunday }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, start_of_week) }
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return week with 2013-03-03 as the date' do
            expect(weeks).to_not be_empty
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
            expect(weeks).to_not include end_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
            expect(weeks).to_not include end_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            expect(weeks).to_not be_empty
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
          end
        end
      end

      context '2013-03-05(Tuesday) to 2013-03-31(Sunday)' do
        let(:start_date) { Date.parse('2013-03-05') }
        let(:end_date) { Date.parse('2013-03-31') }
        let(:start_of_week) { :sunday }
        let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, start_of_week) }
        context 'when include is nil' do
          let(:weeks) { drange.weeks_covered }
          it 'should return weeks of 10, 17 and 24' do
            expect(weeks.length).to eq 3
            expect(weeks).to include Date.parse('2013-03-10')
            expect(weeks).to include Date.parse('2013-03-17')
            expect(weeks).to include Date.parse('2013-03-24')
          end
        end

        context 'when include is :start_week' do
          let(:weeks) { drange.weeks_covered(:include => :start_week) }
          it 'should return beginning of start week' do
            expect(weeks.length).to eq 4
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
            expect(weeks).to include Date.parse('2013-03-10')
            expect(weeks).to include Date.parse('2013-03-17')
            expect(weeks).to include Date.parse('2013-03-24')
            expect(weeks).to_not include end_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :end_week' do
          let(:weeks) { drange.weeks_covered(:include => :end_week) }
          it 'should return beginning of end week' do
            expect(weeks.length).to eq 4
            expect(weeks).to_not include start_date.beginning_of_week(start_of_week)
            expect(weeks).to include Date.parse('2013-03-10')
            expect(weeks).to include Date.parse('2013-03-17')
            expect(weeks).to include Date.parse('2013-03-24')
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
          end
        end

        context 'when include is :both' do
          let(:weeks) { drange.weeks_covered(:include => :both) }
          it 'should return beginning of start week and end week' do
            expect(weeks.length).to eq 5
            expect(weeks).to include start_date.beginning_of_week(start_of_week)
            expect(weeks).to include Date.parse('2013-03-10')
            expect(weeks).to include Date.parse('2013-03-17')
            expect(weeks).to include Date.parse('2013-03-24')
            expect(weeks).to include end_date.beginning_of_week(start_of_week)
          end
        end
      end
    end
  end

  describe "#dates_covered" do
    context "when start_date and end_date are the same" do
      let(:date) { Date.today }
      let(:start_of_week) { :sunday }
      let(:drange) { DateRangeCovers::DateRange.new(date, date, start_of_week) }

      context 'when include is nil' do
        let(:dates)  { drange.dates_covered }
        it { expect(dates).to be_empty }
      end

      context 'when include is set to :both' do
        let(:dates)  { drange.dates_covered(:include => :both) }
        it { expect(dates).to include date }
      end

      context 'when include is set to :start_date' do
        let(:dates)  { drange.dates_covered(:include => :start_date) }
        it { expect(dates).to include date }
      end

      context 'when include is set to :end_date' do
        let(:dates)  { drange.dates_covered(:include => :end_date) }
        it { expect(dates).to include date }
      end
    end

    context "when start_date and end_date are different" do
      let(:start_date) { Date.today - 1 }
      let(:end_date) { Date.today }
      let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }

      context 'when include is nil' do
        let(:dates)  { drange.dates_covered }
        it { expect(dates).to be_empty }
      end

      context 'when include is set to :start_date' do
        let(:dates)  { drange.dates_covered(:include => :start_date) }
        it { expect(dates.length).to eq 1 }
        it { expect(dates).to include start_date }
        it { expect(dates).to_not include end_date }
      end

      context 'when include is set to :end_date' do
        let(:dates) { drange.dates_covered(:include => :end_date) }
        it { expect(dates.length).to eq 1 }
        it { expect(dates).to include end_date }
        it { expect(dates).to_not include start_date }
      end

      context 'when include is set to :both' do
        let(:dates) { drange.dates_covered(:include => :both) }
        it { expect(dates.length).to eq 2 }
        it { expect(dates).to include end_date }
        it { expect(dates).to include start_date }
      end
    end

    context "when start_date and end_date are more than a day apart" do
      let(:start_date) { Date.today - 2 }
      let(:end_date) { Date.today }
      let(:drange) { DateRangeCovers::DateRange.new(start_date, end_date, :sunday) }

      context 'when include is nil' do
        let(:dates)  { drange.dates_covered }
        it { expect(dates.length).to eq 1 }
        it { expect(dates).to_not include start_date }
        it { expect(dates).to_not include end_date }
      end

      context 'when include is set to :start_date' do
        let(:dates)  { drange.dates_covered(:include => :start_date) }
        it { expect(dates.length).to eq 2 }
        it { expect(dates).to include start_date }
        it { expect(dates).to_not include end_date }
      end

      context 'when include is set to :end_date' do
        let(:dates) { drange.dates_covered(:include => :end_date) }
        it { expect(dates.length).to eq 2 }
        it { expect(dates).to include end_date }
        it { expect(dates).to_not include start_date }
      end

      context 'when include is set to :both' do
        let(:dates) { drange.dates_covered(:include => :both) }
        it { expect(dates.length).to eq 3 }
        it { expect(dates).to include end_date }
        it { expect(dates).to include start_date }
      end
    end
  end
end
