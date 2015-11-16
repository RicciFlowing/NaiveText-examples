class PostGenerator
  def self.create_posts(args)
    text_creator = TextCreator.new
    posts_text = text_creator.create_texts(args[:count], args[:path])
    posts_text.each do |text|
      puts text
      Post.create(text: text, content_type: args[:content_type])
    end
  end
end

class TextCreator
  def create_texts(count, path)
    @text = File.read(path)
    @words = @text.split
    prng = Random.new
    texts = []
    count.times do
      texts << create_text(prng)
    end
    texts
  end

  private
    def create_text(prng)
      text = @words[prng.rand(@words.count), 11].join(' ')
    end
end
