module Wizardry
  class Base
    @steps = {}
    @@adapter = SpellBooks::ActiveRecordSpellBook

    def self.step(name, options)
      add_step(name, options)
      define_step_methods(name)
    end

    def update(name, params)
      steps[name].update(params)
    end

    def valid?(name)
      self.class.adapter.valid?(steps[name])
    end

  
    class << self
      def adapter; @@adapter end
      def adapter=(adapter); @@adapter = adapter end
      
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