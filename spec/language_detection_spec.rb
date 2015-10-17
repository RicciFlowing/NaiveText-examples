require 'spec_helper'

describe LanguageDetection do
  let(:subject) { LanguageDetection.new }

  describe 'run' do
    it 'returns an appriote response' do
      expect(subject.run(text: "I am an english text")).to eq "english"
      expect(subject.run(text: "die der und Ich bin in deutsch geschrieben")).to eq "german"
      expect(subject.run(text: "Jag heter NaiveText")).to eq "swedish"
    end
  end

end
