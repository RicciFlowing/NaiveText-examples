require "NaiveText"

class LanguageDetection
  def initialize
    categories_config = [{name: 'german', path: 'spec/training_2/german'},
                         {name: 'english', path: 'spec/training_2/english'},
                         {name: 'swedish', path: 'spec/training_2/swedish'},
                       ]
    @classifier = NaiveText.build(categories_config)
  end

  def run(args)
    @classifier.classify(args[:text]).name
  end

end
