# frozen_string_literal: true

require 'test_helper'
# test state and behaviour

class StateAndBehaviourTest < Minitest::Spec
  subject { StateAndBehaviour::Car.new }
  let(:car_class) { StateAndBehaviour::Car }
  let(:default_car) { car_class.new({}) }

  it 'defines class Car' do
    car_class
  end

  describe 'Car' do
    describe '.default_car' do
      it 'returns car instance with default attributes' do
        car_class.stub(:new, default_car) do
          car_class.default_car.must_be :==, default_car
        end
      end
    end

    describe '#initialize' do
      it 'expects hash of attributes' do
        -> { subject }.must_raise ArgumentError
      end

      it 'sets year, color, model' do
        car = car_class.new(car_attributes)
        (car.instance_variables - expected_variables)
          .must_equal [:@current_speed]
        car_attributes.each do |k, v|
          car.instance_variable_get("@#{k}").must_equal v
        end
      end

      it 'provides default values' do
        expected_variables.each do |var|
          default_car.instance_variable_get(var).wont_be :nil?
        end
      end

      it 'inits @current_speed' do
        default_car.instance_variable_get(:@current_speed)
      end
    end

    describe '#color' do
      it 'returns @color attribute value' do
        assert_getter(:color)
      end
    end

    describe '#model' do
      it 'returns @model attribute value' do
        assert_getter(:model)
      end
    end

    describe '#year' do
      it 'returns @year attribute value' do
        assert_getter(:color)
      end
    end

    describe '#current_speed' do
      it 'returns @current_speed attribute value' do
        assert_getter(:current_speed)
      end
    end

    describe '#speed_up' do
      it 'expects parameter' do
        -> { default_car.speed_up }.must_raise ArgumentError
      end

      it 'returns full info' do
        default_car.speed_up(8)
        default_car.current_speed.must_equal 8
      end
    end

    describe '#push_break' do
      it 'expects parameter' do
        -> { default_car.push_break }.must_raise ArgumentError
      end

      it 'decrements current_speed' do
        default_car.instance_variable_set(:@current_speed, 8)
        default_car.push_break(7)
        default_car.current_speed.must_equal(1)
      end

      it 'does nothing if negative velocity is greater than speed' do
        default_car.instance_variable_set(:@current_speed, 6)
        default_car.push_break(7)
        default_car.current_speed.must_equal(6)
      end
    end
  end

  def expected_variables
    %i[@year @color @model]
  end

  def car_attributes
    { color: 'purple',
      model: 'skyline',
      year: 2015 }
  end

  def assert_getter(sym)
    attribute = default_car.instance_variable_get("@#{sym}")
    default_car.public_send(sym)
               .must_equal attribute
  end
end
