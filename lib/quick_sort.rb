class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = array[0]
    left = array.select{|el| el < pivot}
    right = array.select{|el| el >= pivot}

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}
    return array if length <= 1
    pivot_index = self.partition(array, start, length, &prc)
    self.sort2!(array, start, pivot_index - start, &prc)
    self.sort2!(array, pivot_index + 1, length - pivot_index - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|x, y| x <=> y}
    pivot = array[start]
    pivot_idx = start
    p array

    (start + 1...(length + start)).each do |i|
      el = array[i]
      if prc.call(pivot, el) > -1
        array[i], array[pivot_idx + 1] = array[pivot_idx + 1], array[i]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
