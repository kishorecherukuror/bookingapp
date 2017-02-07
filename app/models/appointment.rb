class Appointment < ActiveRecord::Base

	# validates :name, presence: true
	# validates :phonenumber, presence: true
	# validates :starttime, presence: true

class << self
	def time_slot(date = Date.current)
		workhouse = 8.times.map { |i| Time.new(1,1,1,8,0,0).hour + i }
	    lunchhours = 14
	    working_hours = (workhouse - [lunchhours]).map { |i| "#{i}:00" + (i > 11 ? 'PM' : 'AM') }
	    working_hours - reserved_slots(date)
	end

	 def reserved_slots(date)
	 	Appointment.where(date: date).pluck(:starttime)
	 end

	def booked_slots(date = Date.current)
		#binding.pry
		slots = []
		Appointment.where(:date ==  Date.current.strftime('%m/%d/%y')).each do |i|
			slots << i.starttime
		end
		slots.uniq
	end	
end
end
