require "test_helper"

class PollsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  
  
  

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should get create" do
  #   @post = polls(:one)
  #   get :create, params: {id: @post}, post = {polls}
  #   assert_response :success
  # end





end
