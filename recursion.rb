def range(start_num, end_num)
  return [] if end_num < start_num
  range(start_num, end_num - 1) << end_num
end

def exp1(base, power)
  return 1 if power == 0
  base * exp1(base, power - 1)
end

def exp2(base, power)
  return 1 if power == 0
  return base if power == 1
  if power.even?
    exp2(base, power / 2) ** 2
  elsif power.odd?
    base * (exp2(base, (power - 1) / 2) ** 2)
  end
end

class Array
  def deep_dup
    return [self] if self.size == 1

    dup_array = []

    self.each do |el|
      if el.is_a?(Array)
        dup_array << el.deep_dup
      else
        dup_array << el
      end
    end

    dup_array
  end
end

def fib(n)
  return [1] if n == 1
  return [1,1] if n == 2

  prev_fib_series = fib(n - 1)
  new_fib_number = prev_fib_series[-2..-1].reduce(:+)

  prev_fib_series << new_fib_number
end

def bsearch(array, target)

  return nil unless array.include?(target)

  middle_idx = array.size / 2
  middle_idx -= 1 if array.size.even?
  middle_el = array[middle_idx]

  if array.size == 2
    return 0 if array[0] == target
    return 1 if array[1] == target
  end

  if target < middle_el
    return bsearch(array[0..middle_idx], target)

  elsif middle_el < target
    return middle_idx + bsearch(array[middle_idx..-1], target)

  elsif middle_el == target
    return middle_idx
  end

end

def merge_sort(array)
  return array if array.size <= 1

  n = array.size / 2
  left = array.take(n)
  right = array.drop(n)

  merge(merge_sort(left), merge_sort(right))
end

def merge(left,right)
  merged = []

  until left.empty? || right.empty?
    if left.first < right.first
      merged << left.shift
    else
      merged << right.shift
    end
  end

  merged.concat(left).concat(right)
end

def subsets(arr)
  return [] if arr.empty?
  return [[],arr] if arr.size == 1

  previous_subsets = subsets(arr[0...-1])
  new_subsets = previous_subsets.map do |sub_array|
    sub_array + [arr.last]
  end

  previous_subsets + new_subsets
end

def quick_sort(arr, &prc)
  prc ||= Proc.new{|x,y| x <=> y}

  return arr if arr.size <= 1

  pivot = arr.first

  pivots = arr.select{|el| prc.call(pivot, el) == 0}
  left = arr.select{|el| prc.call(pivot, el) == 1}
  right = arr.select{|el| prc.call(pivot, el) == -1}

  quick_sort(left, &prc) + pivots + quick_sort(right, &prc)
end

def greedy_make_change(amount, coins)
  coins.sort!.reverse!
  return [] if amount < coins.last

  change = []

  coins.each do |coin|
    next if amount < coin
    new_amount = amount - coin
    change << coin
    return change + greedy_make_change(new_amount, coins)
  end

end

def make_better_change(amount, coins)

  coins.sort!.reverse!
  return [] if amount < coins.last

  change_options = []

  coins.each do |coin|
    next if amount < coin

    temp_amount = amount - coin
    change_possibility = [coin]
    change_possibility += make_better_change(temp_amount, coins)

    change_options << change_possibility
  end

  change_options.sort_by{|options| options.size}.first
end
