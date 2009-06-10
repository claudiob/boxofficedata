require 'test_helper'

class WeekendTest < ActiveSupport::TestCase
  test "empty attributes" do
    weekend = Weekend.new
    assert !weekend.valid?
    assert weekend.errors.invalid?(:week)
    assert weekend.errors.invalid?(:year)
  end
  
  test "valid 53 weeks" do
    (1976..2016).each do |year|
      assert year.weeks_in_year.include?(53) == \
      [1976, 1982, 1988, 1993, 1999, 2004, 2010, 2016].include?(year)
    end
  end
  
  test "invalid 53 weeks" do
    weekend = Weekend.new(:year => 2001, :week => 53)
    assert !weekend.valid?
    assert_equal "is invalid", weekend.errors.on(:week) 
  end

  test "too many weeks" do
    weekend = Weekend.new(:year => 2000, :week => 60)
    assert !weekend.valid?
    assert_equal "is invalid", weekend.errors.on(:week)     
  end
  
  test "valid week" do
    weekend = Weekend.new(:year => 2000, :week => 10)
    assert weekend.valid?, weekend.errors.full_messages
  end
end
