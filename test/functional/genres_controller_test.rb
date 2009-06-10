require 'test_helper'

class GenresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genres)
  end

  test "should show genre" do
    get :show, :id => genres(:drama).to_param
    assert_response :success
  end

#  test "should show genre movies" do
#    get :movies, :id => genres(:drama).to_param
#    assert_response :success
#    # should contain titanic
#  end

end
