require "NaiveText"

class InterestingTexts
  def initialize
    categories_config = [{name: 'interesting', path: 'spec/training/positive'},
                         {name: 'boring', path: 'spec/training/negative'}]
    @classifier = NaiveText.build(categories_config)
  end

  def run(args)
    @classifier.classify(args[:text]).name
  end

end
