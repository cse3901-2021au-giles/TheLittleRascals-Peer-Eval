require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


  test "should get index" do
    get '/index'
    assert_response :redirect
  end


  test "should get show" do
    get '/show'
    assert_response :redirect
  end
end
