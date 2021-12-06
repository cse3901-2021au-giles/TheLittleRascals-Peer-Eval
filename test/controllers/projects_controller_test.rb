require "test_helper"

class ProjectsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    project = projects(:one)
    get :show, params: {param: 'project_id'}
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end


end
