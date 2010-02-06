begin
  ApplicationController.send(:public, :logged_in?, :current_<%= file_name %>, :authorized?)
rescue NameError => e
  puts "An exception occurred: #{e}"
  puts 'Did you forget to move "include AuthenticatedSystem" from sessions_controller.rb to application_controller.rb?'
  exit!
end
