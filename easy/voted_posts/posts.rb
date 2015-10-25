require 'NaiveText'

require_relative 'enviroment'

class Post < ActiveRecord::Base
  scope :up_voted, ->{ where(vote: true) }
  scope :down_voted, ->{ where(vote: false) }
end

Post.delete_all

positive = ['ruby is the best programming language', 'rails is awesome', 'active record fot the win']
positive.each do |text|
  Post.create(text: text, vote: true)
end

negative = ['Golf is pretty boring', 'learning chinese seems pretty hard',]
negative.each do |text|
  Post.create(text: text, vote: false)
end

class PostClassifier
  def initialize
    categories_config = [{name: 'interesting', examples: Post.up_voted.to_a},
                         {name: 'boring', examples: Post.down_voted.to_a}]
    @classifier = NaiveText.build(categories: categories_config)
  end

  def like_it?(args)
    @classifier.classify(args[:text]).name == 'interesting'
  end

  def category(args)
    @classifier.classify(args[:text]).name
  end

  def p(args)
    @classifier.propabilities(args[:text])
  end
end

classifier = PostClassifier.new
puts classifier.p(text: "ruby is better then golf")
