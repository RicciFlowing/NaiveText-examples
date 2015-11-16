require 'NaiveText'

require_relative 'enviroment'
require_relative 'post_generator'

class Post < ActiveRecord::Base
  scope :spam, ->{ where(content_type: 'spam') }
  scope :no_spam, ->{ where(content_type: 'verified_content') }
end


class SpamFilter
  def initialize(args)
    @debug_mode = args[:debug_mode] || false
    categories_config = [{name: 'spam', examples: Post.spam, weight: 1},
                         {name: 'no_spam', examples: Post.no_spam, weight: 10}]
    @classifier = NaiveText.build(categories: categories_config, default: 'no_spam')
  end

  def spam?(args)
    post = args[:post]
    puts_text_and_result(post) if @debug_mode
    @classifier.classify(post.text).name == 'spam'
  end

  private
    def puts_text_and_result(post)
      puts post.text
      puts @classifier.classify(post.text).name
      puts @classifier.probabilities(post.text)
    end
end


Post.delete_all

PostGenerator.create_posts(content_type: 'spam', path: 'texts/spam.txt', count: 20)
PostGenerator.create_posts(content_type: 'verified_content', path: 'texts/content.txt', count: 20)

filter = SpamFilter.new(debug_mode: true)

test_texts = [
                'Programming in Ruby is a great pleasure',
                'This post is about finding a new job. We are looking for honest, responsible, hard-working people',
                'NOT_CONTAINED_IN_ANY_TEXT'
             ]

test_texts.each do |text|
  post = Post.new(text: text)
  post.save unless filter.spam?(post: post)
end
