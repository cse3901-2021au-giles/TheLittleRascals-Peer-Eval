require "test_helper"

class TeamsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @teams = teams(:one)
    @user = users(:one)
  end

  test "should get new" do
    get :new, params: {param: @user}
    assert_response :success
  end
end
