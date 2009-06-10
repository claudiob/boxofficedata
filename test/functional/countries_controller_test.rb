require 'test_helper'

class CountriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should show country" do
    get :show, :id => countries(:italy).to_param
    assert_response :success
  end

#  test "should show country results" do
#    get :results, :id => countries(:us).to_param
#    assert_response :success
#    # should contain results(:one)
#  end

end
