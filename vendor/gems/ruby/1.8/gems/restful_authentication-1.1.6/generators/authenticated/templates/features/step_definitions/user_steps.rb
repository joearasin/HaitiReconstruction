Given /^I am not logged in$/ do
  visit '/logout'
end

Given /^I am logged in$/ do
  <%= file_name %> = <%= class_name %>.make
  visit '/login'
  fill_in 'login', :with => <%= file_name %>.login
  fill_in 'password', :with => <%= file_name %>.password
  click_button 'Log in'
end

Then /^I should not be logged in$/ do
  controller.current_<%= file_name %>.should be_nil
end

Then /^I should be logged in$/ do
  controller.current_<%= file_name %>.should_not be_nil
end

Given /^someone with the login "([^\"]*)" already exists$/ do |login|
  <%= class_name %>.make(:login => login)
end

Then /^I should have a remember token$/ do
  controller.current_<%= file_name %>.remember_token.should_not be_nil
end

Then /^I should not have a remember token$/ do
  controller.current_<%= file_name %>.remember_token.should be_nil
end
