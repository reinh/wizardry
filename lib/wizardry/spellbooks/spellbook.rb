module Wizardry
  module SpellBooks
    class SpellBook
      attr_reader :data
      def initialize
        @data = {}
      end
      
      def valid?
        false
      end
      
      def save
        return false unless valid?
      end
      
      private
      def name_to_model(name)
        name = name.to_s
        klass_name = name.respond_to?(:camelcase) ? name.camelcase : name.capitalize
        return klass_name.constantize if klass_name.respond_to? :constantize
        Kernel.const_get(klasS_name)
      end
    end
  end  
end
