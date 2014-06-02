class MemoryDictionary::Word
  include Mongoid::Document
  field :name, type: String
  field :translation, type: String

  embedded_in :dictionary, class_name: 'MemoryDictionary::Dictionary'

  validates :name, uniqueness: true
  validates :name, :translation, presence: true
  index({ name: 1 }, { unique: true, name: 'dictionary_words_index' })
end