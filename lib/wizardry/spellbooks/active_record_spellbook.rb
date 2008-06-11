module Wizardry
  module SpellBooks
    class Wizardry::SpellBooks::ActiveRecordSpellBook < SpellBook
      def valid?
        raise ArgumentError, "Invalid parameters passed" unless data.respond_to?(:each)
        errors = {}
        data.each do |model_name, attributes|
          
          klass = name_to_model(model_name)
          instance = klass.new(attributes)

          # Requred to get errors.
          instance.valid?

          attributes.keys.any? do |key|
            if instance.errors.invalid? key
              errors[model_name] = instance.errors
            end
          end
        end
        errors.empty?
      end
    end
  end  
end
