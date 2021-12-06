require "test_helper"

class PollsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do

    @project_id = polls(:one) 
  
  end
  
  

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should get create" do
  #   @post = polls(:one)
  #   get :create, params: {id: @post}, post = {polls}
  #   assert_response :success
  # end

  

  test "should get show_polls" do
    get :show_polls, params:{id: @project_id}
    assert_response :success
  end



end
