alphabet = ('a'..'z').to_a
hash = {}
i = 0
vowels = ['a','e','i','o','u','y']
alphabet.each do |char|

  i = i + 1
  if vowels.include?(char)
    hash[char] = i
  end

end

puts hash
