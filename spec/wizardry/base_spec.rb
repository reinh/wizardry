require File.dirname(__FILE__) + '/../spec_helper'

describe Wizardry::Base do
  describe "validation_adapter" do
    it "defaults to ActiveRecordSpellBook" do
      pending "implement spellbooks"
      Wizardry::Base.validation_adapter.should == Wizardry::SpellBooks::ActiveRecord
    end
  end
  describe ".step" do    
    it "adds a step" do
      Wizardry::Step.should_receive(:new).with({})
      Wizardry::Base.step :name, {}
    end
    
    it "defines methods to update and validate the step" do
      Wizardry::Base.step :name, {}
      Wizardry::Base.new.should respond_to(:update_name)
      Wizardry::Base.new.should respond_to(:valid_name?)
    end
  end
end
