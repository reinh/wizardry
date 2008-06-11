unless Hash.new.respond_to? :only
  class Hash
    # Returns a new hash with only the given keys.
    def only(accepted)
      reject { |key,| !accepted.include?(key) }
    end
  end
end