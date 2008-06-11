require File.dirname(__FILE__) + '/../../spec_helper'

describe Wizardry::SpellBooks::ActiveRecordSpellBook do
  describe ".valid?" do
    before(:each) do
      Post    = mock("Post")
      @a_post = mock("A Post")
      @errors = mock("Errors")
      @data   = { :post => { :title => "A Title", :subject => "A Subject"}}
    end
    it "checks the validity of each model's attributes from the data" do
      Post.should_receive(:new).with(@data[:post]).and_return(@a_post)
      @a_post.should_receive(:valid?)
      @a_post.should_receive(:errors).at_least(1).times.and_return(@errors)
      @data[:post].keys.each do |attr|
        @errors.should_receive(:invalid?).with(attr)
      end
      Wizardry::SpellBooks::ActiveRecordSpellBook.valid?(@data)
    end
  end
end
