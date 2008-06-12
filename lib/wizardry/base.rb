module Wizardry
  class Base
    def self.step(name, options)
      add_step(name, options)
      define_step_methods(name)
    end

    def update(name, params)
      raise ArgumentError, "Invalid step \"#{name}\"" unless steps[name]
      steps[name].update(params)
    end

    def valid_step?(name)
      steps[name].valid?
    end
    
    def valid?
      all_steps_valid?
    end
    
    def save
      return false unless valid?
      data.save_records
    end
    
    def errors
      steps.map{|_, step| step.errors}
    end

    private
    def self.steps; @steps ||= {} end
    def steps; self.class.steps end
    
    def data
      steps.map{|_, step| step.data}.inject(Wizardry::ModelData.new) do |hash, step_data|
        hash = hash.rmerge(step_data); hash
      end
    end
  
    def all_steps_valid?
      steps.all?{ |_, step| step.valid? }
    end    

    class << self
      private
      
      def add_step(name, options)
        steps[name] = Step.new(options)
      end
  
      def define_step_methods(name)
        define_method "update_#{name}" do |params|
          update name, params
        end
        define_method "valid_#{name}?" do
          valid_step? name
        end
      end
    end
  end
end