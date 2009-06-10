require 'test_helper'

class WeekendsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weekends)
  end

  test "should show weekend" do
    get :show, :id => weekends(:one).to_param
    assert_response :success
  end

end
