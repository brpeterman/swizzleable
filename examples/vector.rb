require 'swizzleable'

# A vector is just a swizzlable array in this case.
class Vector < Array
  include Swizzleable

  # Provides access to swizzle functions like #zyx and similar.
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

def test
  v = Vector.new [1, 2, 3]
  v.zyx # [3, 2, 1]
  v.xxy # [1, 1, 2]
  v.xy # NoMethodError
  v.xyzw #NoMethodError

  v = Vector.new [1, 2, 3, 4, 5]
  v.xyzzy # ArgumentError
end
