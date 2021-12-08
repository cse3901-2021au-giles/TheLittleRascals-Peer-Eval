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

  test "should get create" do
    @post = polls(:one)
    get :new, params: {id: @post}
    assert_response :success
  end


  test "should get show_polls" do
    get :new, params:{id: @project_id}
    assert_response :success
  end


  test "should get edit" do
    get :new, params:{id: @project_id}
    assert_response :success
  end

  test "should get poll params" do
    get :new, params:{id: @project_id}
    assert_response :success
  end


  test "should get poll status" do
    get :new, params:{id: @project_id}
    assert_response :success
  end

  test "should get calculate_ave" do
    get :new, params:{id: @project_id}
    assert_response :success
  end

  test "should get pol res" do
    get :new, params:{id: @project_id}
    assert_response :success
  end

  test "should get final poll queue" do
    get :new, params:{id: @project_id}
    assert_response :success
  end




end
