require 'test_helper'

class BlogControllerTest < ActionController::TestCase
  test "should get _form" do
    get :_form
    assert_response :success
  end

  test "should get _show" do
    get :_show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get admin" do
    get :admin
    assert_response :success
  end

end
