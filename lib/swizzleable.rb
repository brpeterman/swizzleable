# A swizzlable class must respond to these methods:
#  #dup
#  #length
#  #[]
#  #[]=
module Swizzleable
  def swiz_positions
    {'x' => 0, 'y' => 1, 'z' => 2, 'w' => 3}
  end

  def swizzle(pattern)
    if pattern.chars.reject{|c| swiz_positions.keys[0..self.length-1].include? c}.length > 0
      raise ArgumentError.new "Unrecognized characters in swizzle pattern."
    end
    new_vector = self.dup
    pattern.chars.each_with_index {|c, i| new_vector[i] = self[swiz_positions[c]]}
    new_vector
  end
end
