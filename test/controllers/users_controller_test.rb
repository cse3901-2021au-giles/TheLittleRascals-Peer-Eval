require "test_helper"

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = users{:one}
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {param: @user}
    assert_response :success
  end

  test "should get update" do
    get :login_path 
    assert_response :success
  end



end
