require 'test_helper'

class WeekendsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weekends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weekend" do
    assert_difference('Weekend.count') do
      post :create, :weekend => { }
    end

    assert_redirected_to weekend_path(assigns(:weekend))
  end

  test "should show weekend" do
    get :show, :id => weekends(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => weekends(:one).to_param
    assert_response :success
  end

  test "should update weekend" do
    put :update, :id => weekends(:one).to_param, :weekend => { }
    assert_redirected_to weekend_path(assigns(:weekend))
  end

  test "should destroy weekend" do
    assert_difference('Weekend.count', -1) do
      delete :destroy, :id => weekends(:one).to_param
    end

    assert_redirected_to weekends_path
  end
end
