require File.dirname(__FILE__) + '/../test_helper'
require '<%= controller_file_name %>_controller'

# Re-raise errors caught by the controller.
class <%= controller_class_name %>Controller; def rescue_action(e) raise e end; end

class <%= controller_class_name %>ControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  def test_should_login_and_redirect
    <%= file_name %> = <%= class_name %>.make    
    post :create, :login => <%= file_name %>.login, :password => <%= file_name %>.password
    assert session[:<%= file_name %>_id]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :create, :login => 'quentin', :password => 'bad password'
    assert_nil session[:<%= file_name %>_id]
    assert_response :success
  end

  def test_should_logout
    log_in
    get :destroy
    assert_nil session[:<%= file_name %>_id]
    assert_response :redirect
  end

  def test_should_remember_me
    <%= file_name %> = <%= class_name %>.make    
    @request.cookies["auth_token"] = nil
    post :create, :login => <%= file_name %>.login, :password => <%= file_name %>.password, :remember_me => "1"
    assert_not_nil @response.cookies["auth_token"]
  end

  def test_should_not_remember_me
    @request.cookies["auth_token"] = nil
    post :create, :login => 'quentin', :password => 'monkey', :remember_me => "0"
    assert @response.cookies["auth_token"].blank?
  end
  
  def test_should_delete_token_on_logout
    log_in
    get :destroy
    assert @response.cookies["auth_token"].blank?
  end

  def test_should_login_with_cookie
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.remember_me
    @request.cookies["auth_token"] = cookie_for(<%= file_name %>)
    get :new
    assert @controller.send(:logged_in?)
  end

  def test_should_fail_expired_cookie_login
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.remember_me
    <%= file_name %>.update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(<%= file_name %>)
    get :new
    assert !@controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :new
    assert !@controller.send(:logged_in?)
  end

  protected
    def auth_token(token)
      CGI::Cookie.new('name' => 'auth_token', 'value' => token)
    end
    
    def cookie_for(<%= file_name %>)
      auth_token <%= file_name %>.remember_token
    end
end
