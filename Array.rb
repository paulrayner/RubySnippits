class Array
  def sum;     inject(0) { |s, v| s += v }; end
  def product; inject(1) { |s, v| s *= v }; end
end

puts [1, 1, 2, 3, 5, 8].sum
puts [1, 1, 2, 3, 5, 8].product