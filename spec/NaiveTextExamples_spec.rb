require 'spec_helper'

describe NaiveTextExamples do
  it 'has a version number' do
    expect(NaiveTextExamples::VERSION).not_to be nil
  end

  describe 'run' do
    it 'responds to run' do
      expect(subject).to respond_to(:run)
    end
  end

  describe 'list' do
    xit 'returns a list of examples' do
    end
  end

end
