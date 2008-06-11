class Wizardry::Step
  attr_reader :has, :spellbook
  def initialize(options)
    @options = options
    @has     = {}
    @spellbook = Wizardry::Base.spellbook.new
    @has.merge! options[:has] if options[:has]
  end
  
  def data
    spellbook.data
  end
  
  def update(params)
    params.each do |model, atts|
      data[model] = atts.only(has[model])
    end
  end
  
  def valid?
    spellbook.valid?
  end
  
  def save
    spellbook.save
  end
end