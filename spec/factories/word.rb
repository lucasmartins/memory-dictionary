FactoryGirl.define do
  factory :word, class: MemoryDictionary::Word do
    name 'ruby'
    translation 'is awesome'
    factory :word_within_dictionary, class: MemoryDictionary::Word do
      dictionary factory: :dictionary
    end
  end
end
