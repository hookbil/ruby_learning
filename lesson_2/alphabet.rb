alphabet = ('a'..'z').to_a
hash = {}
i = 0

alphabet.each do |key|

  i = i + 1
  vowel = [1,5,9,15,21,25]

  if vowel.include?(i)
    hash[key] = i
  end

end

puts hash