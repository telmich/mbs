require 'test_helper'

class GesamtsControllerTest < ActionController::TestCase
  setup do
    @gesamt = gesamts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gesamts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gesamt" do
    assert_difference('Gesamt.count') do
      post :create, :gesamt => @gesamt.attributes
    end

    assert_redirected_to gesamt_path(assigns(:gesamt))
  end

  test "should show gesamt" do
    get :show, :id => @gesamt.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @gesamt.to_param
    assert_response :success
  end

  test "should update gesamt" do
    put :update, :id => @gesamt.to_param, :gesamt => @gesamt.attributes
    assert_redirected_to gesamt_path(assigns(:gesamt))
  end

  test "should destroy gesamt" do
    assert_difference('Gesamt.count', -1) do
      delete :destroy, :id => @gesamt.to_param
    end

    assert_redirected_to gesamts_path
  end
end
