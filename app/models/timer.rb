class Timer < ActiveRecord::Base

  validates :user_id, presence: true
  validates :expires_at, presence: true
  validates :numbers, presence: true
  
end
