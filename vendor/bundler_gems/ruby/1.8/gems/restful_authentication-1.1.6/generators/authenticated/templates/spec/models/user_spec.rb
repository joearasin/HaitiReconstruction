# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '<%= ('/..'*model_controller_class_nesting_depth) + '/../spec_helper' %>'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe <%= class_name %> do
  describe 'being created' do
    before do
      @<%= file_name %> = nil
      @creating_<%= file_name %> = lambda do
        @<%= file_name %> = create_<%= file_name %>
        violated "#{@<%= file_name %>.errors.full_messages.to_sentence}" if @<%= file_name %>.new_record?
      end
    end

    it 'increments <%= class_name %>#count' do
      @creating_<%= file_name %>.should change(<%= class_name %>, :count).by(1)
    end
<% if options[:include_activation] %>
    it 'initializes #activation_code' do
      @creating_<%= file_name %>.call
      @<%= file_name %>.reload
      @<%= file_name %>.activation_code.should_not be_nil
    end
<% end %><% if options[:stateful] %>
    it 'starts in pending state' do
      @creating_<%= file_name %>.call
      @<%= file_name %>.reload
      @<%= file_name %>.should be_pending
    end
<% end %>  end

  #
  # Validations
  #

  it 'requires login' do
    lambda do
      u = create_<%= file_name %>(:login => nil)
      u.errors.on(:login).should_not be_nil
    end.should_not change(<%= class_name %>, :count)
  end

  describe 'allows legitimate logins:' do
    ['123', '1234567890_234567890_234567890_234567890',
     'hello.-_there@funnychar.com'].each do |login_str|
      it "'#{login_str}'" do
        lambda do
          u = create_<%= file_name %>(:login => login_str)
          u.errors.on(:login).should     be_nil
        end.should change(<%= class_name %>, :count).by(1)
      end
    end
  end
  describe 'disallows illegitimate logins:' do
    ['12', '1234567890_234567890_234567890_234567890_', "tab\t", "newline\n",
     "Iñtërnâtiônàlizætiøn hasn't happened to ruby 1.8 yet",
     'semicolon;', 'quote"', 'tick\'', 'backtick`', 'percent%', 'plus+', 'space '].each do |login_str|
      it "'#{login_str}'" do
        lambda do
          u = create_<%= file_name %>(:login => login_str)
          u.errors.on(:login).should_not be_nil
        end.should_not change(<%= class_name %>, :count)
      end
    end
  end

  it 'requires password' do
    lambda do
      u = create_<%= file_name %>(:password => nil)
      u.errors.on(:password).should_not be_nil
    end.should_not change(<%= class_name %>, :count)
  end

  it 'requires password confirmation' do
    lambda do
      u = create_<%= file_name %>(:password_confirmation => nil)
      u.errors.on(:password_confirmation).should_not be_nil
    end.should_not change(<%= class_name %>, :count)
  end

  it 'requires email' do
    lambda do
      u = create_<%= file_name %>(:email => nil)
      u.errors.on(:email).should_not be_nil
    end.should_not change(<%= class_name %>, :count)
  end

  describe 'allows legitimate emails:' do
    ['foo@bar.com', 'foo@newskool-tld.museum', 'foo@twoletter-tld.de', 'foo@nonexistant-tld.qq',
     'r@a.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail.com',
     'hello.-_there@funnychar.com', 'uucp%addr@gmail.com', 'hello+routing-str@gmail.com',
     'domain@can.haz.many.sub.doma.in', 'student.name@university.edu'
    ].each do |email_str|
      it "'#{email_str}'" do
        lambda do
          u = create_<%= file_name %>(:email => email_str)
          u.errors.on(:email).should     be_nil
        end.should change(<%= class_name %>, :count).by(1)
      end
    end
  end
  describe 'disallows illegitimate emails' do
    ['!!@nobadchars.com', 'foo@no-rep-dots..com', 'foo@badtld.xxx', 'foo@toolongtld.abcdefg',
     'Iñtërnâtiônàlizætiøn@hasnt.happened.to.email', 'need.domain.and.tld@de', "tab\t", "newline\n",
     'r@.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail2.com',
     # these are technically allowed but not seen in practice:
     'uucp!addr@gmail.com', 'semicolon;@gmail.com', 'quote"@gmail.com', 'tick\'@gmail.com', 'backtick`@gmail.com', 'space @gmail.com', 'bracket<@gmail.com', 'bracket>@gmail.com'
    ].each do |email_str|
      it "'#{email_str}'" do
        lambda do
          u = create_<%= file_name %>(:email => email_str)
          u.errors.on(:email).should_not be_nil
        end.should_not change(<%= class_name %>, :count)
      end
    end
  end

  describe 'allows legitimate names:' do
    ['Andre The Giant (7\'4", 520 lb.) -- has a posse',
     '', '1234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890',
    ].each do |name_str|
      it "'#{name_str}'" do
        lambda do
          u = create_<%= file_name %>(:name => name_str)
          u.errors.on(:name).should     be_nil
        end.should change(<%= class_name %>, :count).by(1)
      end
    end
  end
  describe "disallows illegitimate names" do
    ["tab\t", "newline\n",
     '1234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_',
     ].each do |name_str|
      it "'#{name_str}'" do
        lambda do
          u = create_<%= file_name %>(:name => name_str)
          u.errors.on(:name).should_not be_nil
        end.should_not change(<%= class_name %>, :count)
      end
    end
  end

  it 'resets password' do
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    <%= class_name %>.authenticate(<%= file_name %>.login, 'new password').should == <%= file_name %>
  end

  it 'does not rehash password' do
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.update_attributes(:login => 'quentin2')
    <%= class_name %>.authenticate('quentin2', <%= file_name %>.password).should == <%= file_name %>
  end

  #
  # Authentication
  #

  it 'authenticates <%= file_name %>' do
    <%= file_name %> = <%= class_name %>.make
    <%= class_name %>.authenticate(<%= file_name %>.login, <%= file_name %>.password).should == <%= file_name %>
  end

  it "doesn't authenticate <%= file_name %> with bad password" do
    <%= class_name %>.authenticate('quentin', 'invalid_password').should be_nil
  end

 if REST_AUTH_SITE_KEY.blank?
   # old-school passwords
   it "authenticates a <%= file_name %> against a hard-coded old-style password" do
     <%= class_name %>.authenticate('old_password_holder', 'test').should == <%= table_name %>(:old_password_holder)
   end
 else
   it "doesn't authenticate a <%= file_name %> against a hard-coded old-style password" do
     <%= class_name %>.authenticate('old_password_holder', 'test').should be_nil
   end

   # New installs should bump this up and set REST_AUTH_DIGEST_STRETCHES to give a 10ms encrypt time or so
   desired_encryption_expensiveness_ms = 0.1
   it "takes longer than #{desired_encryption_expensiveness_ms}ms to encrypt a password" do
     test_reps = 100
     start_time = Time.now; test_reps.times{ <%= class_name %>.authenticate('quentin', 'monkey'+rand.to_s) }; end_time   = Time.now
     auth_time_ms = 1000 * (end_time - start_time)/test_reps
     auth_time_ms.should > desired_encryption_expensiveness_ms
   end
 end

  #
  # Authentication
  #

  it 'sets remember token' do
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.remember_me
    <%= file_name %>.remember_token.should_not be_nil
    <%= file_name %>.remember_token_expires_at.should_not be_nil
  end

  it 'unsets remember token' do
    <%= file_name %> = <%= class_name %>.make    
    <%= file_name %>.remember_me
    <%= file_name %>.remember_token.should_not be_nil
    <%= file_name %>.forget_me
    <%= file_name %>.remember_token.should be_nil
  end

  it 'remembers me for one week' do
    <%= file_name %> = <%= class_name %>.make
    before = 1.week.from_now.utc
    <%= file_name %>.remember_me_for 1.week
    after = 1.week.from_now.utc
    <%= file_name %>.remember_token.should_not be_nil
    <%= file_name %>.remember_token_expires_at.should_not be_nil
    <%= file_name %>.remember_token_expires_at.between?(before, after).should be_true
  end

  it 'remembers me until one week' do
    <%= file_name %> = <%= class_name %>.make
    time = 1.week.from_now.utc
    <%= file_name %>.remember_me_until time
    <%= file_name %>.remember_token.should_not be_nil
    <%= file_name %>.remember_token_expires_at.should_not be_nil
    <%= file_name %>.remember_token_expires_at.should == time
  end

  it 'remembers me default two weeks' do
    <%= file_name %> = <%= class_name %>.make
    before = 2.weeks.from_now.utc
    <%= file_name %>.remember_me
    after = 2.weeks.from_now.utc
    <%= file_name %>.remember_token.should_not be_nil
    <%= file_name %>.remember_token_expires_at.should_not be_nil
    <%= file_name %>.remember_token_expires_at.between?(before, after).should be_true
  end
<% if options[:stateful] %>
  it 'registers passive <%= file_name %>' do
    <%= file_name %> = create_<%= file_name %>(:password => nil, :password_confirmation => nil)
    <%= file_name %>.should be_passive
    <%= file_name %>.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    <%= file_name %>.register!
    <%= file_name %>.should be_pending
  end

  it 'suspends <%= file_name %>' do
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.suspend!
    <%= file_name %>.should be_suspended
  end

  it 'does not authenticate suspended <%= file_name %>' do
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.suspend!
    <%= class_name %>.authenticate('quentin', 'monkey').should_not == <%= file_name %>
  end

  it 'deletes <%= file_name %>' do
    <%= file_name %> = <%= class_name %>.make
    <%= file_name %>.deleted_at.should be_nil
    <%= file_name %>.delete!
    <%= file_name %>.deleted_at.should_not be_nil
    <%= file_name %>.should be_deleted
  end

  describe "being unsuspended" do

    before do
      @<%= file_name %> = <%= class_name %>.make
      @<%= file_name %>.suspend!
    end

    it 'reverts to active state' do
      @<%= file_name %>.unsuspend!
      @<%= file_name %>.should be_active
    end

    it 'reverts to passive state if activation_code and activated_at are nil' do
      <%= class_name %>.update_all :activation_code => nil, :activated_at => nil
      @<%= file_name %>.reload.unsuspend!
      @<%= file_name %>.should be_passive
    end

    it 'reverts to pending state if activation_code is set and activated_at is nil' do
      <%= class_name %>.update_all :activation_code => 'foo-bar', :activated_at => nil
      @<%= file_name %>.reload.unsuspend!
      @<%= file_name %>.should be_pending
    end
  end
<% end %>
protected
  def create_<%= file_name %>(options = {})
    record = <%= class_name %>.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.<% if options[:stateful] %>register! if record.valid?<% else %>save<% end %>
    record
  end
end
