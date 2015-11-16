class SpamFilter
  def initialize
    categories_config = [{name: 'spam', examples: Post.spam, weight: 1},
                         {name: 'content', examples: Post.verified, weight: 10}]
    @classifier = NaiveText.build(categories: categories_config, default: 'content')
  end

  def spam?(args)
    post = args[:post]
    @classifier.classify(post.text).name == 'spam'
  end
end
