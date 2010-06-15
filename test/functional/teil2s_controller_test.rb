require 'test_helper'

class Teil2sControllerTest < ActionController::TestCase
  setup do
    @teil2 = teil2s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teil2s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teil2" do
    assert_difference('Teil2.count') do
      post :create, :teil2 => @teil2.attributes
    end

    assert_redirected_to teil2_path(assigns(:teil2))
  end

  test "should show teil2" do
    get :show, :id => @teil2.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @teil2.to_param
    assert_response :success
  end

  test "should update teil2" do
    put :update, :id => @teil2.to_param, :teil2 => @teil2.attributes
    assert_redirected_to teil2_path(assigns(:teil2))
  end

  test "should destroy teil2" do
    assert_difference('Teil2.count', -1) do
      delete :destroy, :id => @teil2.to_param
    end

    assert_redirected_to teil2s_path
  end
end
