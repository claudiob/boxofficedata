require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test "should show result" do
    get :show, :id => results(:one).to_param
    assert_response :success
  end
end
