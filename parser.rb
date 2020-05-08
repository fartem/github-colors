require 'yaml'
require 'json'
require 'csv'
require 'open-uri'

languages_raw = open('https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml') { |f|
    f.read
}
languages_data = YAML::load(languages_raw)

languages = {}
languages_data.each { |language|
    color = language[1]['color']
    if !color.nil?
        languages[language[0]] = color
    end
}

File.open('./colors.json', 'w') do |f|
    f.write(JSON.pretty_generate(languages))
end

CSV.open('./colors.cvs', 'w') do |f|
    languages.to_a.each { |language|
        f << language
    }
end
