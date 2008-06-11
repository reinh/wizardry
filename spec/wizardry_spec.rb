require File.dirname(__FILE__) + '/spec_helper'

describe Wizardry do
  describe ".step" do    
    it "adds a step" do
      Wizardry::Step.should_receive(:new).with({})
      Wizardry.step :name, {}
    end
    
    it "defines methods to update and validate the step" do
      Wizardry.step :name, {}
      Wizardry.new.should respond_to(:update_name)
      Wizardry.new.should respond_to(:valid_name?)
    end
  end
end
