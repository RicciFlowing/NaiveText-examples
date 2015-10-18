require "NaiveText"

class LanguageDetector
  def initialize
    categories_config = [{name: 'german', path: 'training/german'},
                         {name: 'english', path: 'training/english'},
                         {name: 'swedish', path: 'training/swedish'},
                       ]
    @classifier = NaiveText.build(categories_config)
  end

  def get_language(args)
    puts @classifier.classify(args[:text]).name
  end

  def propabilities(args)
     @classifier.propabilities(args[:text])
  end
end

detector = LanguageDetector.new
# Get the language for a text written in on language
puts detector.get_language(text: 'This is obviously an english text') # ==> english
puts detector.get_language(text: 'Der Text ist deutsch')              # ==> german
puts detector.get_language(text: 'Jag heter Susan')                   # ==> swedish

# Eplore was happens if their is more than one language in a text
multi_language = 'This is an english text containing just one german word "Herren" meaning gentleman. Lets see what happens.'
puts detector.propabilities(text: multi_language)
