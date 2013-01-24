require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.new(email:"example@example.com", password:"12345678", password_confirmation: "12345678")
    @user.save
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @user.id
    assert_response :success
  end

end
