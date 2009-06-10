require 'test_helper'

class StudiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studios)
  end

  test "should show studio" do
    get :show, :id => studios(:sony).to_param
    assert_response :success
  end

end
