# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(*a)
  # WRITE THIS CODE
  a.each do |side|
    raise TriangleError if side.nil? || side <= 0 
  end  
  raise TriangleError if a[0]+a[1] <= a[2] || a[0]+a[2] <= a[1] || a[1] + a[2] <= a[0]  
  [:equilateral, :isosceles, :scalene][(a.uniq.size - 1)]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
