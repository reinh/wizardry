class Wizardry::Step
  attr_reader :has, :data
  def initialize(options)
    @options = options
    @has     = {}
    @data    = {}
    @has.merge! options[:has] if options[:has]
  end
  
  def update(params)
    params.each do |model, atts|
      @data[model] = atts.only(has[model])
    end
  end
  
  def valid?
  end
  
  def save
    return false unless valid?
  end
end