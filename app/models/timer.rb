class Timer < ActiveRecord::Base

  validates :user_id, presence: true
  validates :expires_at, presence: true
  validates :numbers, presence: true
  
  def is_expired?
    DateTime.now > expires_at
  end

  def trigger

  end

  def self.check_timers
    timers = Timer.all
    for timer in timers
      if timer.is_expired?
        puts 'Timer expired'
        puts timer.user_id
        for contact in JSON.parse(timer.numbers)
          if contact['number']
              Api.new.sendtext(contact['number'], "Help I might be in trouble, please check on me: http://late-night-safety-kit.herokuapp.com/tracks/#{timer.user_id} ")
          elsif contact['email']
              Api.new.sendemail(contact['email'], "help", "Help I'm in trouble!")
          end
        end
        timer.destroy
      end
    end
  end
end
