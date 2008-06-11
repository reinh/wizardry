require File.dirname(__FILE__) + '/../../spec_helper'
require 'rubygems'
require 'activerecord'

class Post < ActiveRecord::Base
end

class PostWithValidation < Post
  validates_inclusion_of :title, :in => "A Valid Title"
end

describe Wizardry::SpellBooks::ActiveRecordSpellBook do
  before(:each) do
    @spellbook = Wizardry::SpellBooks::ActiveRecordSpellBook.new
  end
  describe ".valid?" do
    before(:each) do
    end
    it "returns true if all the models have valid attributes for that step" do
      data = { :post => { :title => "A Title", :subject => "A Subject"}}
      @spellbook.data.merge!(data)      
      @spellbook.should be_valid
    end
    it "returns false if there are validation errors for the attributes in the step" do
      data = { :post_with_validation => { :title => "A Title", :subject => "A Subject"}}
      @spellbook.data.merge!(data)      
      @spellbook.should_not be_valid
    end
  end
end
