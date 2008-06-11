module Wizardry
  module SpellBooks
    class ActiveRecordSpellBook < SpellBook
      def self.valid?(data)
        data.each do |model_name, attributes|
          klass = name_to_model(model_name)
          instance = klass.new(attributes)
          # Requred to get errors.
          instance.valid?
          not attributes.keys.any? do |key|
            instance.errors.invalid? key
          end
        end
      end
    end
  end  
end
