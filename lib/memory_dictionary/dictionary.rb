class MemoryDictionary::Dictionary
  include Mongoid::Document
  field :name, type: String

  embeds_many :words, class_name: 'MemoryDictionary::Word'

  validates :name, uniqueness: true
  index({ name: 1 }, { unique: true, name: 'dictionary_names_index' })
  #index 'words.name' => 1

  def translations
    words.map(&:translation).uniq
  end

  def words_by_translation(translation)
    words.where(translation: translation)
  end

  def append_word(name, translation)
    words << MemoryDictionary::Word.new(name: name, translation: translation)
  end

end