require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    wayne = users(:one)
    post :create, name: wayne.name, password: 'secret'
    assert_redirected_to admin_url
    assert_equal wayne.id, session[:user_id]
  end

  test "should fail login" do
    post :create, name: "invalid name", password: "wrong password"
    assert_redirected_to login_path
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to store_path
  end

end
