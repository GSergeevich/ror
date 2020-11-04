#!/usr/bin/env ruby

vowels = %w[a e i o u]
hash = {}
('a'..'z').each_with_index {|letter,i| hash[letter] = i + 1 if vowels.include? letter}
p hash
