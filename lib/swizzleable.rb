# A swizzlable class must respond to these methods:
#  #dup
#  #length
#  #[]
#  #[]=
module Swizzleable
  def define_swiz_positions(positions = nil)
    if positions == nil
      @swizzle_positions = ['x', 'y', 'z', 'w']
        .each_with_index
        .each_with_object({}) do |c, i, hash|
        hash[c] = i
      end
    else
      @swizzle_positions = positions
    end
  end

  def swizzle(pattern)
    if !instance_variable_defined? :@swizzle_positions
      define_swiz_positions
    end
    if pattern.chars.reject{|c| @swizzle_positions.keys[0..self.length-1].include? c}.length > 0
      raise ArgumentError.new "Unrecognized characters in swizzle pattern."
    end
    new_vector = self.dup
    pattern.chars.each_with_index {|c, i| new_vector[i] = self[@swizzle_positions[c]]}
    new_vector
  end
end
