module Wizardry
  class ModelData < Hash
    def inspect
      "<ModelData: #{super}>"
    end
    def save_records
      all? do |name, attributes|
        klass = name_to_model(name)
        klass.new(attributes).save
      end
    end
    
    private
    def name_to_model(name)
      name = name.to_s
      klass_name = name.respond_to?(:camelcase) ? name.camelcase : name.capitalize
      return klass_name.constantize if klass_name.respond_to? :constantize
      Kernel.const_get(klass_name)
    end
  end
end
