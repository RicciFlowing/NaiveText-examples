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
    @classifier.classify(args[:text]).name
  end

  def p(args)
    puts @classifier.propabilities(args[:text])
  end
end

detector = LanguageDetector.new
detector.p(text: 'This is obviously an english text')
detector.p(text: 'Der Text ist deutsch')
detector.p(text: 'Jag heter Susan')
