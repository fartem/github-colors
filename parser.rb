require 'yaml'
require 'json'
require 'csv'
require 'open-uri'

colors_url = 'https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml'
languages_raw = URI.parse(colors_url, &:read).open
languages_data = YAML.safe_load(languages_raw)

languages = {}
languages_data.each do |language|
  color = language[1]['color']
  languages[language[0]] = color unless color.nil?
end

File.open('./colors.json', 'w') do |f|
  f.write(JSON.pretty_generate(languages))
end

CSV.open('./colors.cvs', 'w') do |f|
  languages.to_a.each { |language| f << language }
end
