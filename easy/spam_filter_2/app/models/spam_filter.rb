class SpamFilter

  def self.spam?(post)
    self.build_classifer
    @classifier.classify(post.text).name == 'spam'
  end

  private
    def self.build_classifer
      categories_config = [{name: 'spam', examples: Post.spam, weight: 1},
                           {name: 'content', examples: Post.verified, weight: 10}]
      @classifier = NaiveText.build(categories: categories_config, default: 'content')
    end
end
