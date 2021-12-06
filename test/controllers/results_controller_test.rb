require "test_helper"

class ResultsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  #setup do
  #  @result = Result(rater_id: 1, ratee_id: 1, poll_id: 1)
  #  @poll = Poll(1)
    # @project = Project(1)
    # @team = Team(1)
    # @user = User
  # end





  test "should get new" do
    @poll = polls(:one)
    get :new, params: {id: @poll.id}
    assert_response :success
  end
  
  test "should get create" do
    get :create, params:{id: @project_id}
    assert_response :success
  end



end
