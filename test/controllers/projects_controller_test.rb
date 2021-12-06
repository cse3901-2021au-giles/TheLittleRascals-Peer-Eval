require "test_helper"

class ProjectsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end


  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should get create" do
  #   @post = projects(:one)
  #   get :create, params: {id: @post}, post = {polls}
  #   assert_response :success
  # end

  test "should get show" do
    get :show
    assert_response :success
  end




end
