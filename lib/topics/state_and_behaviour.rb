# frozen_string_literal: true

# exercise state and behaviour
module StateAndBehaviour

end
class Car
  attr_accessor :year,:color,:model,:current_speed


def initialize (car_attributes)
  @year=car_attributes[:year] || 2015
  @color=car_attributes[:color] || 'purple'
  @model=car_attributes[:model] || 'skyline'
  @current_speed = car_attributes[:current_speed] = 8
  end

def speed_up (speed_is_raising)
  @current_speed+=speed_is_raising
end

def push_break (speed_decrease)
  @current_speed-=speed_decrease
end

def self.default_car
  Car.new(default_car)
end
end
