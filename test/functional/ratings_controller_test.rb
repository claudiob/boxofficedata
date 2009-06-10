require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ratings)
  end

  test "should show rating" do
    get :show, :id => ratings(:r).to_param
    assert_response :success
  end

#  test "should show rating movies" do
#    get :movies, :id => ratings(:r).to_param
#    assert_response :success
#    # should contain titanic
#  end
end
