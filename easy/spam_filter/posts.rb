require 'NaiveText'

require_relative 'enviroment'
require_relative 'text_creator'

class Post < ActiveRecord::Base
  scope :spam, ->{ where(content_type: 'spam') }
  scope :no_spam, ->{ where(content_type: 'verified_content') }
end


class SpamFilter
  def initialize()
    categories_config = [{name: 'spam', examples: Post.spam, weight: 1},
                         {name: 'no_spam', examples: Post.no_spam, weight: 1}]
    @classifier = NaiveText.build(categories: categories_config)
  end

  def spam?(args)
    post = args[:post]
    puts post.text
    puts @classifier.classify(post.text).name
    puts @classifier.probabilities(post.text)
    @classifier.classify(post.text).name == 'spam'
  end
end



Post.delete_all
spam_texts       = File.read('spam.txt')
verified_content = File.read('content.txt')



spam_generator    = TextCreator.new(spam_texts)
content_generator = TextCreator.new(verified_content)


spam_generator.create_texts(30).each do |text|
  Post.create(text: text, content_type: 'spam')
  puts text
end

content_generator.create_texts(30).each do |text|
  Post.create(text: text, content_type: 'verified_content')
end

filter = SpamFilter.new

test_texts = ["Programming Rails is great pleasure",
   "This post is about finding a new job. We are looking for honest, responsible, hard-working people",
    "What happens when?"]

test_texts.each do |text|
  post = Post.new(text: text)
  post.save unless filter.spam?(post: post)
end
