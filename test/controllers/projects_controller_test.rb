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
    test_project_id = 1
    test_user_id = 1

    get :new, params: {id: test_project_id}
    assert_response :success
  end

  test "should get destroy" do
   get :new
   assert_response :success
  end




end
