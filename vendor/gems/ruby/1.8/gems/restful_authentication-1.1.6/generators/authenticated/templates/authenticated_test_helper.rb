module AuthenticatedTestHelper
  def log_in
    <%= file_name %> = <%= class_name %>.make
    @request.session[:<%= file_name %>_id] = <%= file_name %>.id
  end

  def authorize
    <%= file_name %> = <%= class_name %>.make
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Basic.encode_credentials(<%= file_name %>.login, <%= file_name %>.password)
  end
  
end
