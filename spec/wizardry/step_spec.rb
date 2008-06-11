require File.dirname(__FILE__) + '/../spec_helper'

describe Wizardry::Step do
  describe ".new" do
    it "sets its related models from the :has options" do
      step = Wizardry::Step.new(:has => {:model => :attr})
      step.models.should == {:model => :attr}      
    end
  end
end
