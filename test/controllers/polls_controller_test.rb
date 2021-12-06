require "test_helper"

class PollsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    @poll = polls(:one)
    get :new
    assert_response :success
  end

  test "should get show_polls" do
    @poll = polls(:one)
    get :new
    assert_response :success
  end


end
