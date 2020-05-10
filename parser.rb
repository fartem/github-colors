#!/usr/bin/ruby

require 'yaml'
require 'json'
require 'csv'
require 'open-uri'

colors_url = 'https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml'
languages_raw = URI.open(colors_url, &:read)
languages_data = YAML.safe_load(languages_raw)

languages = {}
languages_data.each do |language|
  color = language[1]['color']
  languages[language[0]] = color unless color.ni?
end

File.open('./colors.json', 'w') do |f|
  f.write(JSON.pretty_generate(languages))
end

CSV.open('./colors.cvs', 'w') do |f|
  languages.to_a.each { |language| f << language }
end
