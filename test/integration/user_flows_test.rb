require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
    test "should get login site" do 
        https!
        get "/login"
        assert_response :success
    end

    test "should get signup site" do 
        https!
        get "/users/new?"
        assert_response :success
    end

    test "should get reset password site" do 
        https!
        get "/password?"
        assert_response :success
    end

    test "should not get users site without login" do 
        https!
        get "/users/1"
        assert_response :redirect
    end

    test "should get adding project site" do 
        https!
        get "/projects/new?group_id=1"
        assert_response :success
    end







end
