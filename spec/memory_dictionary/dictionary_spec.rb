require "spec_helper"

describe MemoryDictionary::Dictionary do
  #smoke test

  let(:dictionary) { create(:dictionary_with_words) }

  before(:each) { dictionary.save }

  describe "#words" do
    it "has words" do
      expect(dictionary.reload.words.count).to eq(2)
    end
  end

  describe "#translations" do
    it "retrieve translations" do
      expect(dictionary.reload.translations).to eq(["is awesome", "is faster"])
    end
  end

  describe "#words_by_translation" do
    it "search words by translation" do
      words = dictionary.reload.words_by_translation("is faster")
      expect(words.count).to eq(1)
      expect(words.first.name).to eq('rubinius')
    end
  end

  describe "#append_word" do
    it "appends a new word" do
      expect{ dictionary.reload.append_word('jruby', 'is jruby...') }.to change{ dictionary.reload.words.count}.by 1
    end
  end

end
