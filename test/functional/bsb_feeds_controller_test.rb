require 'test_helper'

class BsbFeedsControllerTest < ActionController::TestCase
  setup do
    @bsb_feed = bsb_feeds(:one)
    @bsb_feed.reload_attributes

    @user = User.new(email:"example@example.com", password:"12345678", password_confirmation: "12345678")
    @user.save
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bsb_feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bsb_feed" do
    assert_difference('BsbFeed.count') do
      post :create, bsb_feed: {url: "http://xkcd.com/atom.xml"}
    end

    assert_redirected_to bsb_feed_path(assigns(:bsb_feed))
  end

  test "should show bsb_feed" do
    get :show, id: @bsb_feed
    assert_response :success
  end

  test "should get edit" do
  get :edit, id: @bsb_feed
    assert_response :success
  end

  test "should update bsb_feed" do
    put :update, id: @bsb_feed, bsb_feed: { last_update: @bsb_feed.last_update, read_index: @bsb_feed.read_index, title: @bsb_feed.title, url: @bsb_feed.url }
    assert_redirected_to bsb_feed_path(assigns(:bsb_feed))
  end

  test "should destroy bsb_feed" do
    assert_difference('BsbFeed.count', -1) do
      delete :destroy, id: @bsb_feed
    end

    assert_redirected_to bsb_feeds_path
  end
end
