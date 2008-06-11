require File.dirname(__FILE__) + '/../spec_helper'

describe Wizardry::Base do
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
  
  describe ".new with a step named :name" do
    before do
      Wizardry::Base.step :name, {}
      @name_step = Wizardry::Base.steps[:name]
      @wizard = Wizardry::Base.new
      @params = mock("Params")
    end

    it "#update_name delegates update of a step's parameters to the step" do
      @name_step.should_receive(:update).with(@params)
      @wizard.update_name(@params)
    end

    it "#valid_name? delegates checking validity of a step to the step" do
      @name_step.should_receive(:valid?)
      @wizard.valid_name?
    end
  end

  describe ".adapter" do
    it "defaults to ActiveRecordSpellBook" do
      Wizardry::Base.adapter.should == Wizardry::SpellBooks::ActiveRecordSpellBook
    end
  end
end
