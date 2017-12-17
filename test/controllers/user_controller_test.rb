require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get catogory" do
    get :catogory
    assert_response :success
  end

  test "should get book" do
    get :book
    assert_response :success
  end

end
