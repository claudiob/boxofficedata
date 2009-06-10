require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, :group => {:name => "Rails::Test"}
    end
    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, :id => groups(:pixar).to_param
    assert_response :success
  end

#  test "should show group movies" do
#    get :movies, :id => groups(:loved_movies).to_param
#    assert_response :success
#    # should contain titanic
#  end

#  test "should show group results" do
#    get :results, :id => groups(:loved_movies).to_param
#    assert_response :success
#  end

  test "should get edit" do
    get :edit, :id => groups(:pixar).to_param
    assert_response :success
  end

  test "should update group" do
    put :update, :id => groups(:pixar).to_param, :group => { }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, :id => groups(:pixar).to_param
    end

    assert_redirected_to groups_path
  end
end
