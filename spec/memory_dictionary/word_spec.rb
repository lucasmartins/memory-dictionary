require "spec_helper"

describe MemoryDictionary::Word do
  #smoke test
  describe "#dictionary" do
    let(:word) { create(:word_within_dictionary) }
    it "belongs to a dictionary" do
      expect(word.dictionary.id).not_to be_nil
    end
  end
end
