class TextCreator
  def initialize(text)
    @words = text.split(/\W+/)
  end

  def create_texts(count)
    prng = Random.new
    texts = []
    count.times do
      texts << create_text(prng)
    end
    texts
  end

  private
    def create_text(prng)
      text = ""
      7.times do
        text += ' ' + @words[prng.rand(@words.count)]
      end
      text
    end
end
