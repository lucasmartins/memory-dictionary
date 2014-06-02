require "spec_helper"

describe MemoryDictionary::Translator do

  #smoke test
  describe "#initialize" do

    context 'when theres a dictionary' do
      let(:dictionary) { create(:dictionary) }
      let(:translator) { MemoryDictionary::Translator.new(dictionary.name) }
      it "has a dictionary" do
        expect{translator}.not_to raise_error
      end
    end

    context 'when there is no dictionary' do
      let(:translator) { MemoryDictionary::Translator.new('wut?') }
      it "does not have a dictionary" do
        expect{translator}.to raise_error(MemoryDictionary::Errors::DictionaryNotFoundException)
      end
    end
  
  end

  describe '#translate_word' do
    let(:dictionary) { create(:dictionary_with_words) }
    let(:translator) { MemoryDictionary::Translator.new(dictionary.name) }
    context 'when word exists' do
      it 'translates the word' do
        expect(translator.translate('ruby')).to eq('is awesome')
      end
    end
    context 'when word do not exist' do
      it 'raises WordNotFoundException' do
        expect{translator.translate('waka waka')}.to raise_error(MemoryDictionary::Errors::WordNotFoundException)
      end
    end    
  end

  describe '#add_word' do
    let(:dictionary) { create(:dictionary, name: 'empty-dic') }
    let(:translator) { MemoryDictionary::Translator.new(dictionary.name) }

    context 'without a block' do
      it 'adds a new word to the dictionary' do
        expect(dictionary.words.count).to eq(0)
        expect{ translator.add_word('new word', 'new translation') }.to change{ dictionary.reload.words.count }.by(1)
      end
      it 'translates a recently added word' do
        translator.add_word('recently added word', 'recently added translation')
        expect(translator.translate('recently added word')).to eq('recently added translation')
      end
    end

    context 'with a block' do
      it 'translates a word and runs a block' do
        translator.add_word('recently added word', 'recently added translation') do
          expect(translator.translate('recently added word')).to eq('recently added translation')
        end
      end
    end

  end

  describe '.add_word' do
    let(:dictionary) { create(:dictionary, name: 'instance-dic') }
    let(:translator) { MemoryDictionary::Translator.new(dictionary.name) }
    
    it 'calls the instance method with all the params' do
      pending 'unstable travis exec'
      translator
      block = lambda do
        puts "I'm a block"
      end
      MemoryDictionary::Translator.any_instance.should_receive(:add_word).with('new word', 'new translation', &block)
      MemoryDictionary::Translator.add_word('instance-dic', 'new word', 'new translation', &block)
    end
  end

end
