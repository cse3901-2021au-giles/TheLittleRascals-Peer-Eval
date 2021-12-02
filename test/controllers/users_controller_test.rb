require "test_helper"

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  @user = users{:one}

  test "should get new" do
    get :new
    assert_response :success
  end



end
