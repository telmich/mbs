require 'test_helper'

class Teil1sControllerTest < ActionController::TestCase
  setup do
    @teil1 = teil1s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teil1s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teil1" do
    assert_difference('Teil1.count') do
      post :create, :teil1 => @teil1.attributes
    end

    assert_redirected_to teil1_path(assigns(:teil1))
  end

  test "should show teil1" do
    get :show, :id => @teil1.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @teil1.to_param
    assert_response :success
  end

  test "should update teil1" do
    put :update, :id => @teil1.to_param, :teil1 => @teil1.attributes
    assert_redirected_to teil1_path(assigns(:teil1))
  end

  test "should destroy teil1" do
    assert_difference('Teil1.count', -1) do
      delete :destroy, :id => @teil1.to_param
    end

    assert_redirected_to teil1s_path
  end
end
