module Wizardry
  class Base
    @steps = {}
    @@spellbook = SpellBooks::ActiveRecordSpellBook

    def self.step(name, options)
      add_step(name, options)
      define_step_methods(name)
    end

    def update(name, params)
      steps[name].update(params)
    end

    def valid?(name)
      steps[name].valid?
    end

    class << self
      def spellbook; @@spellbook end
      def spellbook=(spellbook); @@spellbook = spellbook end
      
      private
      
      def add_step(name, options)
        @steps[name] = Step.new(options)
      end
  
      def define_step_methods(name)
        define_method "update_#{name}" do |params|
          update :name, params
        end
        define_method "valid_#{name}?" do
          valid? :name
        end
      end
    end
  
    private
    def self.steps; @steps end
    def steps; self.class.steps end
  end
end