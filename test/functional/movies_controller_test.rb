require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should show movie" do
    get :show, :id => movies(:titanic).to_param
    assert_response :success
  end

#  test "should show movie results" do
#    get :results, :id => movies(:titanic).to_param
#    assert_response :success
#    # should contain results(:one)
#  end

end
