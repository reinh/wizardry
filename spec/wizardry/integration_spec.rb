require File.dirname(__FILE__) + '/../spec_helper'

class Comment < ActiveRecord::Base
  validates_presence_of :title, :body, :subject, :author_id
end

class Author < ActiveRecord::Base
  validates_presence_of :name
end

describe "A Wizardry class with two steps and two models" do
  class Wizard < Wizardry::Base
    step :one, :has => { :comment => [:title, :body, :subject]}
    step :two, :has => { :comment => [:author_id], :author => [:name]}
  end
  
  before(:each) do
    @wizard = Wizard.new
  end
  
  describe "\nwhen updating the first step" do
    describe " with valid params" do
      before(:each) do
        @wizard.update_one :comment => { :title => "A Title", :body => "A Body", :subject => "A Subject"}
      end
      
      it "the first step is valid" do
        @wizard.should be_valid_one
      end
      
      it "the second step is not valid" do
        @wizard.should_not be_valid_two
      end
      
      it "the wizard does not save" do
        @wizard.save.should be_false
      end
    end

  end
  
  
  describe "\nwhen updating both steps" do
    describe " with valid params" do
      before(:each) do
        @wizard.update_one :comment => { :title => "A Title", :body => "A Body", :subject => "A Subject"}
        @wizard.update_two :comment => { :author_id => 1}, :author => { :name => "Bob" }
      end
      
      it "the first step is valid" do
        @wizard.should be_valid_one
      end
      
      it "the second step is valid" do
        @wizard.should be_valid_two
      end
      
      it "the wizard saves" do
        @wizard.save.should be_true
      end
      
      it "it creates an author" do
        lambda {@wizard.save}.should change(Author, :count)
      end
      
      it "it creates a comment" do
        require 'pp'
        @wizard.save
        lambda {@wizard.save}.should change(Comment, :count)
      end
    end

  end
  

end