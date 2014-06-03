class MemoryDictionary::Translator
  def initialize(dictionary_name)
    begin
      @dictionary = MemoryDictionary::Dictionary.find_by(name: dictionary_name)  
    rescue Mongoid::Errors::DocumentNotFound => e
      MemoryDictionary.logger.debug e
      raise MemoryDictionary::Errors::DictionaryNotFoundException
    end
  end

  def translate(word)
    begin
      word = @dictionary.words.find_by(name: word)
      word.translation
    rescue Mongoid::Errors::DocumentNotFound => e
      MemoryDictionary.logger.debug e
      raise MemoryDictionary::Errors::WordNotFoundException
    end
  end

  def add_word(word, translation, &block)
    @dictionary.words << MemoryDictionary::Word.new(name: word, translation: translation)
    block.call if block_given?
  end

  def self.add_word(dictionary, word, translation, &block)
    translator = MemoryDictionary::Translator.new(dictionary)
    translator.add_word(word, translation, &block)
  end

end
