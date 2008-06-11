module Wizardry
  module SpellBooks
    class SpellBook
      private
      def self.name_to_model(name)
        name = name.to_s
        Kernel.const_get(name.respond_to?(:camelcase) ? name.camelcase : name.capitalize)
      end
    end
  end  
end
