class Wizardry::Step
  attr_reader :has, :data, :instances, :errors
  def initialize(options)
    raise ArgumentError, "Must provide a has option" unless options[:has]
    @options   = options
    @has       = options[:has]
    @data      = Wizardry::ModelData.new
    @instances = {}
    @errors    = {}
  end
  
  def update(params)
    params.each do |model, atts|
      filtered_atts = atts.only(has[model])
      data[model] = filtered_atts
    end
  end
  
  def valid?
    clear_errors
    return false if data.empty?
    data.each do |model_name, attributes|

      klass = name_to_model(model_name)
      instances[model_name] = klass.new(attributes)

      # Required to get errors.
      instances[model_name].valid?

      attributes.keys.any? do |key|
        if instances[model_name].errors.invalid? key
          errors[model_name] = instances[model_name].errors
        end
      end
    end
    errors.empty?
  end
  
  def save
    return false unless valid?
    save_each_instance
  end
  
  private
  def clear_errors
    @errors = {}
  end
  
  def name_to_model(name)
    name = name.to_s
    klass_name = name.respond_to?(:camelcase) ? name.camelcase : name.capitalize
    return klass_name.constantize if klass_name.respond_to? :constantize
    Kernel.const_get(klasS_name)
  end
end