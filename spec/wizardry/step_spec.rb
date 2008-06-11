require File.dirname(__FILE__) + '/../spec_helper'

describe Wizardry::Step do
  before do
    @step = Wizardry::Step.new :has => { :post => [:title, :subject, :author_id] }
  end
  describe ".new" do
    it "sets its related models from the :has options" do
      step = Wizardry::Step.new(:has => {:model => :attr})
      step.has.should == {:model => :attr}      
    end
  end
  
  describe "#update" do
    before do
      @params = { :post => {
        :title     => "A Title",
        :subject   => "A Subject",
        :exceprpt  => "An Excerpt",
        :author_id => 123
      }}
    end

    it "stores the parameters for each model in the data hash" do
      @step.update(@params)
      @step.data[:post][:title].should == "A Title"
    end

    it "only stores the parameters specified in the has option in the data hash" do
      @step.update(@params)
      @step.data[:post][:excerpt].should be_nil
    end
  end
  
  describe "#save" do
    it "returns false if the step is not valid" do
      @step.should_receive(:valid?).and_return(false)
      @step.save.should == false
    end
  end
  
  describe "#valid?" do
    it "delegates validation to the adapter" do
      data = mock("Data")
      @step.stub!(:data).and_return(data)
      Wizardry::Base.adapter.should_receive(:valid?).with(data)
      @step.valid?
    end
  end
end
