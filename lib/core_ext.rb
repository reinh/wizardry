unless Hash.new.respond_to? :only
  class Hash
    # Returns a new hash with only the given keys.
    def only(accepted)
      reject { |key,| !accepted.include?(key) }
    end
    def rmerge(second)
       # From: http://www.ruby-forum.com/topic/142809
       # Author: Stefan Rusterholz
  
       merger = proc { |key,v1,v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
       self.merge(second, &merger)
  
    end
  end  
end