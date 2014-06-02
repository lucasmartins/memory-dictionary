class MemoryDictionary::Dictionary
  include Mongoid::Document
  field :name, type: String

  embeds_many :words, class_name: 'MemoryDictionary::Word'

  validates :name, uniqueness: true
  index({ name: 1 }, { unique: true, name: 'dictionary_names_index' })
  #index 'words.name' => 1
end