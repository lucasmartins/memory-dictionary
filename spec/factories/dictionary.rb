FactoryGirl.define do
  factory :dictionary, class: MemoryDictionary::Dictionary do
    name 'rosetta-stone'

    factory :dictionary_with_words, class: MemoryDictionary::Dictionary do
      words {[MemoryDictionary::Word.new(name: 'ruby', translation: 'is awesome'), MemoryDictionary::Word.new(name: 'rubinius', translation: 'is faster')]}
    end
  end
end