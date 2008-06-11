class Wizardry
  @steps = {}

  def self.step(name, options)
    add_step(name, options)
    define_step_methods(name)
  end
  
  private
  def self.steps; @steps end
  def steps; self.class.steps end
  
  class << self
    def add_step(name, options)
      @steps[name] = Step.new(options)
    end
  
    def define_step_methods(name)
      define_method "update_#{name}" do
      end
      define_method "valid_#{name}?" do
      end
    end
  end
end