<%= class_name %>.blueprint do
  login { Faker::Internet.user_name }
  password 'testing'
  password_confirmation { password }
  email { Faker::Internet.email }
<% if options[:include_activation] -%>
  activation_code { nil }
  activated_at { 5.days.ago }
<% end -%>
<% if options[:stateful] -%>
  state { 'active' }
<% end -%>
end