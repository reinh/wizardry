require File.dirname(__FILE__) + '/../spec_helper'
class PostWizard < Wizardry::Base
  step :post, :has => { :post => [:title]}
end

class Post < ActiveRecord::Base
  validates_presence_of :title
end

describe Wizardry::Base do
  before do
    @wizard = Wizardry::Base.new
    @post_wizard = PostWizard.new
  end
  
  describe "#update" do
    it "stores the attributes for the step" do
      @post_wizard.update_post :post => { :title => "A Title"}
      @post_wizard.send(:steps)[:post].send(:data)[:post][:title].should_not be_nil
    end
  end
  describe ".step" do    
    it "adds a step" do
      Wizardry::Step.should_receive(:new).with({:has => {:post => [:title]}})
      Wizardry::Base.step :name, :has => {:post => [:title]}
    end
    
    it "defines methods to update and validate the step" do
      Wizardry::Base.step :name, {:has => {:post => [:title]}}
      Wizardry::Base.new.should respond_to(:update_name)
      Wizardry::Base.new.should respond_to(:valid_name?)
    end
  end
  
  describe ".new with a step named :name" do
    before do
      Wizardry::Base.step :name, {:has => {:post => [:title]}}
      @name_step = Wizardry::Base.steps[:name]
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
  
  describe "#valid?" do
    
    before(:each) do
      @post_wizard = PostWizard.new
    end

    it "returns false if any of the steps are invalid" do
      @post_wizard.update_post :post => { :title => nil}
      @post_wizard.should_not be_valid
    end
    
    it "returns true if all steps are valid" do
      @post_wizard.update_post :post => { :title => "A Title"}
      # raise @post_wizard.send(:steps).inspect
      @post_wizard.send(:steps)[:post].send(:data)[:post][:title].should_not be_nil
      @post_wizard.should be_valid
    end
  end
  
  describe "#save" do    
    before(:each) do
      @post_wizard = PostWizard.new
    end
    
    describe " with an invalid step" do
      before(:each) do
        @post_wizard.update_post :post => { :title => nil}        
      end
      
      it "returns false" do
        @post_wizard.save.should be_false        
      end
      
      it "does not save the record" do
        lambda { @post_wizard.save }.should_not change(Post, :count)
      end
    end
    
    describe " with valid steps" do
      before(:each) do
        @post_wizard.update_post :post => { :title => "A Title"}
      end
      
      it "returns true" do
        @post_wizard.save.should be_true
      end
      
      it "saves the record" do
        lambda { @post_wizard.save }.should change(Post, :count)
      end
    end
  end
  
  describe "#data" do
    before(:each) do
      @wizard = Wizardry::Base.new
    end
    it "combines the attributes from all steps" do
      step1 = mock("Step")
      step1.stub!(:data).and_return({ :post => { :title => "A Title"}})
      step2 = mock("Step")
      step2.stub!(:data).and_return({ :post => { :subject => "A Subject"}})
      @wizard.stub!(:steps).and_return({:one => step1, :two => step2})
      @wizard.send(:data).should == { :post => { :title => "A Title", :subject => "A Subject"}}
    end
  end
end

describe "Two different subclasses of Wizardry::Base" do
  class WizardA < Wizardry::Base; step :one, :has => { :post => [:title] } end
  class WizardB < Wizardry::Base; step :two, :has => { :post => [:title] } end
  it "do not share steps" do
    WizardB.send(:steps)[:one].should be_nil
  end
end