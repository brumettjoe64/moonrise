require 'test_helper'

class AdminMailerControllerTest < ActionController::TestCase
  test "should get send" do
    get :send
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get test" do
    get :test
    assert_response :success
  end

end
