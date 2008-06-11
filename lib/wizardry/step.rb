class Wizardry::Step
  attr_reader :models
  def initialize(options)
    @options = options
    @models = {}
    has options[:has] if options[:has]
  end

  private
  def has(models)
    add_models(models)
  end

  def add_models(models)
    @models.merge!(models)
  end
end