require 'swizzleable'

# A vector is just a swizzlable array in this case.
class Vector < Array
  include Swizzleable

  def method_missing(method, *args, &block)
    if method.to_s.chars.reject{|c| swiz_positions.keys[0..self.length-1].include? c}.length == 0
      if method.to_s.length != self.length
        super
      end

      if self.length > 4
        raise ArgumentError "Only vectors of length <= 4 may be swizzled"
      end

      swizzle(method.to_s)
    end
  end
end
