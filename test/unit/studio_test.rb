require 'test_helper'

class StudioTest < ActiveSupport::TestCase
  test "missing attributes" do
    studio = Studio.new
    assert !studio.valid?
    assert studio.errors.invalid?(:name)
    assert studio.errors.invalid?(:code)
  end
  
  test "duplicate code" do
    # to do
    assert true
  end

  test "name too long" do
    studio = Studio.new(:name => "x" * 33, :code => "test")
    assert !studio.valid?
    assert_equal "too long", studio.errors.on(:name) 
  end

  test "code too long" do
    studio = Studio.new(:name => "test", :code => "x" * 65)
    assert !studio.valid?
    assert_equal "too long", studio.errors.on(:code) 
  end

end