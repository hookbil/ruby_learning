alphabet = ('a'..'z').to_a
hash = {}
i = 0

alphabet.each do |key|

  i = i + 1
  vowel = ['a','e','i','o','u','y']

  if vowel.include?(key)
    hash[key] = i
  end

end

puts hash
