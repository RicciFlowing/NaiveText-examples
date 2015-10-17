require "NaiveText"

class InterestingTextFinder
  def initialize
    categories_config = [{name: 'interesting', path: 'training/positive'},
                         {name: 'boring', path: 'training/negative'}]
    @classifier = NaiveText.build(categories_config)
  end

  def like_it?(args)
    return @classifier.classify(args[:text]).name == 'interesting'
  end
end


finder = InterestingTextFinder.new
puts finder.like_it?(text: "Programming")
