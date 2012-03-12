module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def order(string1, string2)
    string1 == string2 ? "hilite": ""
  end
  
  def selected(str, array)
    if array.index(str) == nil
      false
    else
      true
    end
  end
end
