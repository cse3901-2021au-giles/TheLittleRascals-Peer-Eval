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


  test "should get index" do
    get :new, params: {id: @user}
    assert_response :success
  end

  test "should get create" do
    get :new, params: {id: @user}
    assert_response :success
  end

  test "should get edit" do
    get :new, params: {id: @user}
    assert_response :success
  end

  test "should get update" do
    get :new, params: {id: @user}
    assert_response :success
  end

end
