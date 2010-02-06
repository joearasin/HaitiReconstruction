class Frob < ActiveRecord::Base
  def self.active
    find(:first).token
  end

  def self.active=(newToken)
    find(:first).update_attribute(:token, newToken)
  end

  def self.old?
     (Time.now - find(:first).updated_at).round > 1.hour
  end
end
