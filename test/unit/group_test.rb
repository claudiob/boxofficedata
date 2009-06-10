require 'test_helper'

class GroupTest < ActiveSupport::TestCase
#  fixtures :groups
  
  test "missing name" do
    group = Group.new
    assert !group.valid?
    assert group.errors.invalid?(:name)
  end
  
  test "Sci-Fi excluding E.T." do
    loved_movies = groups(:loved_movies).movies
    assert_equal true, loved_movies.include?(movies(:titanic))
    assert_equal true, loved_movies.include?(movies(:bladerunner))
    assert_equal false, loved_movies.include?(movies(:et))
  end

end
