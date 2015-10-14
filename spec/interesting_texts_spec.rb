require 'spec_helper'

describe InterestingTexts do
  let(:subject) { InterestingTexts.new }

  describe 'run' do
    it 'returns an appriote response' do
      expect(subject.run(text: "Programming")).to eq "interesting"
      expect(subject.run(text: "Golf")).to eq "boring"
    end
  end

end
