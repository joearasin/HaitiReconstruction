require File.dirname(__FILE__) + '/../test_helper'

class <%= class_name %>Test < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper

  def test_should_create_<%= file_name %>
    assert_difference '<%= class_name %>.count' do
      <%= file_name %> = create_<%= file_name %>
      assert !<%= file_name %>.new_record?, "#{<%= file_name %>.errors.full_messages.to_sentence}"
    end
  end
<% if options[:include_activation] %>
  def test_should_initialize_activation_code_upon_creation
    <%= file_name %> = create_<%= file_name %>
    <%= file_name %>.reload
    assert_not_nil <%= file_name %>.activation_code
  end
<% end %><% if options[:stateful] %>
  def test_should_create_and_start_in_pending_state
    <%= file_name %> = create_<%= file_name %>
    <%= file_name %>.reload
    assert <%= file_name %>.pending?
  end

<% end %>
  def test_should_require_login
    assert_no_difference '<%= class_name %>.count' do
      u = create_<%= file_name %>(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference '<%= class_name %>.count' do
      u = create_<%= file_name %>(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference '<%= class_name %>.count' do
      u = create_<%= file_name %>(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference '<%= class_name %>.count' do
      u = create_<%= file_name %>(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal <%= file_name %>, <%= class_name %>.authenticate(<%= file_name %>.login, 'new password')
  end

  def test_should_not_rehash_password
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.update_attributes(:login => 'quentin2')
    assert_equal <%= file_name %>, <%= class_name %>.authenticate('quentin2', <%= file_name %>.password)
  end

  def test_should_authenticate_<%= file_name %>
    <%= file_name %> = <%= class_name %>.make    
    assert_equal <%= file_name %>, <%= class_name %>.authenticate(<%= file_name %>.login, <%= file_name %>.password)
  end

  def test_should_set_remember_token
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.remember_me
    assert_not_nil <%= file_name %>.remember_token
    assert_not_nil <%= file_name %>.remember_token_expires_at
  end

  def test_should_unset_remember_token
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.remember_me
    assert_not_nil <%= file_name %>.remember_token
    <%= file_name %>.forget_me
    assert_nil <%= file_name %>.remember_token
  end

  def test_should_remember_me_for_one_week
    <%= file_name %> = <%= class_name %>.make    
    before = 1.week.from_now.utc
    <%= file_name %>.remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil <%= file_name %>.remember_token
    assert_not_nil <%= file_name %>.remember_token_expires_at
    assert <%= file_name %>.remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.remember_me_until time
    assert_not_nil <%= file_name %>.remember_token
    assert_not_nil <%= file_name %>.remember_token_expires_at
    assert_equal <%= file_name %>.remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil <%= file_name %>.remember_token
    assert_not_nil <%= file_name %>.remember_token_expires_at
    assert <%= file_name %>.remember_token_expires_at.between?(before, after)
  end
<% if options[:stateful] %>
  def test_should_register_passive_<%= file_name %>
    <%= file_name %> = create_<%= file_name %>(:password => nil, :password_confirmation => nil)
    assert <%= file_name %>.passive?
    <%= file_name %>.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    <%= file_name %>.register!
    assert <%= file_name %>.pending?
  end

  def test_should_suspend_<%= file_name %>
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.suspend!
    assert <%= file_name %>.suspended?
  end

  def test_suspended_<%= file_name %>_should_not_authenticate
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.suspend!
    assert_not_equal <%= file_name %>, <%= class_name %>.authenticate(<%= file_name %>.login, <%= file_name %>.password)
  end

  def test_should_unsuspend_<%= file_name %>_to_active_state
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.suspend!
    assert <%= file_name %>.suspended?
    <%= file_name %>.unsuspend!
    assert <%= file_name %>.active?
  end

  def test_should_unsuspend_<%= file_name %>_with_nil_activation_code_and_activated_at_to_passive_state
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.suspend!
    <%= class_name %>.update_all :activation_code => nil, :activated_at => nil
    assert <%= file_name %>.suspended?
    <%= file_name %>.reload.unsuspend!
    assert <%= file_name %>.passive?
  end

  def test_should_unsuspend_<%= file_name %>_with_activation_code_and_nil_activated_at_to_pending_state
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.suspend!
    <%= class_name %>.update_all :activation_code => 'foo-bar', :activated_at => nil
    assert <%= file_name %>.suspended?
    <%= file_name %>.reload.unsuspend!
    assert <%= file_name %>.pending?
  end

  def test_should_delete_<%= file_name %>
    <%= file_name %> = <%= class_name %>.make    
    assert_nil <%= file_name %>.deleted_at
    <%= file_name %>.delete!
    assert_not_nil <%= file_name %>.deleted_at
    assert <%= file_name %>.deleted?
  end
<% end %>
protected
  def create_<%= file_name %>(options = {})
    record = <%= class_name %>.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.<% if options[:stateful] %>register! if record.valid?<% else %>save<% end %>
    record
  end
end
