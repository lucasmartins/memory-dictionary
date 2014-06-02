require "spec_helper"

describe MemoryDictionary::Dictionary do
  #smoke test
  describe "#words" do
    let(:dictionary) { create(:dictionary_with_words) }
    it "has words" do
      dictionary.save
      expect(dictionary.reload.words.count).to eq(2)
    end
  end
end
