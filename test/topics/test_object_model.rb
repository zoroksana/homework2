# frozen_string_literal: true

require 'test_helper'

class ObjectModelTest < Minitest::Spec
  subject { ObjectModel::Laptop.new }
  let(:laptop) { ObjectModel::Laptop }
  let(:linux_friendly_role) { ObjectModel::LinuxFriendly }
  let(:parent) { laptop.superclass }
  let(:parent_instance) { parent.new }
  let(:generic_object) do
    create_singleton_struct('Desktop')
  end

  it 'has "Laptop" class defined' do
    laptop
  end

  it 'has "LinuxFriendly" module defined' do
    linux_friendly_role
  end

  describe 'Laptop' do
    describe '.superclass' do
      it 'has superclass other than Object' do
        parent.wont_equal Object
      end
    end

    describe '#mine_bitcoins' do
      it 'does not implement it' do
        laptop.instance_methods(false).wont_include :mine_bitcoins
      end

      it 'inherits from his parent' do
        subject.must_respond_to :mine_bitcoins
      end
    end

    describe '#fork_process' do
      it 'does not implement it' do
        laptop.instance_methods(false).wont_include :fork_process
      end

      it 'inherits from his parent' do
        subject.must_respond_to :fork_process
      end

      it 'returns "Parent: allocate memory"' do
        subject.fork_process.must_equal 'Parent: allocate memory'
      end
    end

    describe '.ancestors' do
      it 'has prepended module "LinuxFriendly"' do
        laptop.ancestors.first.must_equal linux_friendly_role
      end
    end
  end

  describe 'Laptop`s parent class' do
    describe '#fork_process' do
      it 'implements method' do
        parent.instance_methods.must_include :fork_process
      end

      it 'returns string "Parent: allocate memory"' do
        parent_instance.fork_process.must_equal 'Parent: allocate memory'
      end

      it 'returns details about self(use inspect)' do
        parent_instance.mine_bitcoins.must_equal parent_instance.inspect
      end
    end
  end

  describe 'LinuxFriendly' do
    describe '#fork_process' do
      before(:example) { generic_object.extend linux_friendly_role }

      it 'implements method' do
        generic_object.must_respond_to :fork_process
      end

      it 'passes control up to the ancestors chain' do
        -> { generic_object.fork_process }.must_raise NoMethodError
      end
    end
  end

  def create_singleton_struct(name, fields = {})
    if Struct.const_defined? name
      Struct.const_get name
    else
      Struct.new name, *fields
    end
  end
end
