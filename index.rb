# frozen_string_literal: true

dictionary = File.open('google-10000-english-no-swears.txt')
dictionary = dictionary.read

puts dictionary
