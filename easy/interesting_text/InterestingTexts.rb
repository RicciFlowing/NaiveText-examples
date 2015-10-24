require "NaiveText"

class InterestingTextFinder
  def initialize
    interesting_examples = ExamplesFactory.from_files('training/positive')
    boring_examples = ExamplesFactory.from_files('training/negative')

    categories_config = [{name: 'interesting', examples: interesting_examples},
                         {name: 'boring', examples: boring_examples}]
    @classifier = NaiveText.build(categories: categories_config)
  end

  def like_it?(args)
    return @classifier.classify(args[:text]).name == 'interesting'
  end


end


finder = InterestingTextFinder.new
puts finder.like_it?(text: "Programming")
## => true
