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

    get project_path, params: {id: test_project_id}
    project = assigns(:project)
    assert_equal 1, project.id
    assert_response :success
  end

  #test "should get destroy" do
  #  @project = create(1)
  #  get :user_path(@project)
  #  assert_response :success
  #end


end
