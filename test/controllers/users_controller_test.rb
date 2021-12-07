require "test_helper"

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = users(:one)
  end

  test "should get new" do
    
    get :new, params: { id: @user.id }
    assert_response :success
  end

  test "should get edit" do

    get :edit, params: {fname: 'MyString',
    lname: 'MyString', email: 'MyString', password_digest: 'MyString', admin: false}
    assert_response :success
  end

  test "should get update" do
    get :update 
    assert_response :success
  end



end
 