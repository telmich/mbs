require 'test_helper'

class MachineStatusesControllerTest < ActionController::TestCase
  setup do
    @machine_status = machine_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:machine_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create machine_status" do
    assert_difference('MachineStatus.count') do
      post :create, :machine_status => @machine_status.attributes
    end

    assert_redirected_to machine_status_path(assigns(:machine_status))
  end

  test "should show machine_status" do
    get :show, :id => @machine_status.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @machine_status.to_param
    assert_response :success
  end

  test "should update machine_status" do
    put :update, :id => @machine_status.to_param, :machine_status => @machine_status.attributes
    assert_redirected_to machine_status_path(assigns(:machine_status))
  end

  test "should destroy machine_status" do
    assert_difference('MachineStatus.count', -1) do
      delete :destroy, :id => @machine_status.to_param
    end

    assert_redirected_to machine_statuses_path
  end
end
