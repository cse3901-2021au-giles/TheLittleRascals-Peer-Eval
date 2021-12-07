require "test_helper"

class ResultsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @result = results(:one)
  end

  test "should get new" do
    get :new, params: {id:@result.id}
    assert_response :success
  end
  
  test "should get create" do
    get :create, params:{id: @project_id}
    assert_response :success
  end



end
