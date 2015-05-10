class Array
  def pluck(key)
    map { |h| h[key] }
  end
end