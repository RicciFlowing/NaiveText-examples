require 'NaiveText'

require_relative 'enviroment'


class Post < ActiveRecord::Base
  scope :spam, ->{ where(category: 'spam') }
  scope :no_spam, ->{ where(category: 'verified_content') }
end


class SpamFilter
  def initialize()
    #If one of these words are found the post is automatically Spam
    @stop_words        = ["BAD", "GOLF"]

    categories_config = [{name: 'spam', examples: Post.spam, weight: 1},
                         {name: 'content', examples: Post.no_spam, weight: 2}]
    @classifier = NaiveText.build(categories: categories_config)
  end

  def spam?(args)
    post = args[:post]
    if contains_stop_word?(post.text)
      return true
    end
    @classifier.classify(post.text).name == 'spam'
  end

  private

  def contains_stop_word?(text)
    words = text.split(/\W+/)
    words.map! {|word| word.upcase}
    return (words & @stop_words).length > 0
  end

end

Post.delete_all

spam              = ["This is a spam mail", "I sell you my broken car", "Here are some boring advertisment"]
verified_content  = ["I love ruby", "Rails Programming is awesome", "Css is no fun, without using Sass", "Math for the win"]
test_texts        = ["Programming Rails is great pleasure", "This post is about ruby, but also contains a BAD word", "What happen here?"]


spam.each do |text|
  Post.create(text: text,category: 'spam')
end

verified_content.each do |text|
  Post.create(text: text, category: 'verified_content')
end

filter = SpamFilter.new

test_texts.each do |text|
  post = Post.new(text: text)
  post.save unless filter.spam?(post: post)
  puts post.text
  puts filter.spam?(post: post)
end
