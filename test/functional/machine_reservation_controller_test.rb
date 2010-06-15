require 'test_helper'

class MachineReservationControllerTest < ActionController::TestCase
  test "should get reserve" do
    get :reserve
    assert_response :success
  end

end
