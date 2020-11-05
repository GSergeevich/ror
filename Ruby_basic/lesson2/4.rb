#!/usr/bin/env ruby

vowels = %w[a e i o u]
hash = {}
('a'..'z').each.with_index(1) { |letter, i| hash[letter] = i if vowels.include? letter }
p hash
