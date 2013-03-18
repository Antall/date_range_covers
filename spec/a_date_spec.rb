require 'lib/a_date'
require 'date'

describe Date do
  describe '#beginning_of_week and #end_of_week' do

    context 'when beginning_of_week day is sunday' do
      context 'when date is a sunday' do
        let(:date) { Date.parse('2013-03-03') }

        it 'should return 2013-03-03' do
          ADate.beginning_of_week(date).should == date
        end
        
        it 'should return 2013-03-09' do
          ADate.end_of_week(date).should == Date.parse('2013-03-09')
        end
      end
 
      context 'when date is a monday' do
        let(:date) { Date.parse('2013-03-04') }

        it 'should return 2013-03-03' do
          ADate.beginning_of_week(date).should == Date.parse('2013-03-03')
        end
        
        it 'should return 2013-03-09' do
          ADate.end_of_week(date).should == Date.parse('2013-03-09')
        end
      end
 
      context 'when date is a saturday' do
        let(:date) { Date.parse('2013-03-09') }

        it 'should return 2013-03-03' do
          ADate.beginning_of_week(date).should == Date.parse('2013-03-03')
        end
        
        it 'should return 2013-03-09' do
          ADate.end_of_week(date).should == Date.parse('2013-03-09')
        end
      end
    end
 
    context 'when beginning_of_week day is monday' do
      context 'when date is a sunday' do
        let(:date) { Date.parse('2013-03-03') }

        it 'should return 2013-02-25' do
          ADate.beginning_of_week(date, :monday).should == Date.parse('2013-02-25')
        end
 
        it 'should return 2013-03-03' do
          ADate.end_of_week(date, :monday).should == Date.parse('2013-03-03')
        end
      end
 
      context 'when date is a monday' do
        let(:date) { Date.parse('2013-03-04') }

        it 'should return 2013-03-04' do
          ADate.beginning_of_week(date, :monday).should == Date.parse('2013-03-04')
        end
        
        it 'should return 2013-03-10' do
          ADate.end_of_week(date, :monday).should == Date.parse('2013-03-10')
        end
      end
 
      context 'when date is a saturday' do
        let(:date) { Date.parse('2013-03-09') }

        it 'should return 2013-03-04' do
          ADate.beginning_of_week(date, :monday).should == Date.parse('2013-03-04')
        end
        
        it 'should return 2013-03-10' do
          ADate.end_of_week(date, :monday).should == Date.parse('2013-03-10')
        end
      end
    end
  
  end
end


