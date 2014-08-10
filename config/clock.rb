require 'clockwork'
include Clockwork
require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../config/environment', __FILE__)
 
every(1.minutes, 'check.timers') { Timer.check_timers }
 