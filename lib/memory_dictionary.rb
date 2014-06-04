if File.exists?('.env')
  require 'dotenv'
  Dotenv.load
end

require 'yaml'
require 'bundler'
require 'json'
require 'mongoid'
require 'yajl-ruby' if RUBY_PLATFORM=='ruby'

Encoding.default_internal = "utf-8"
Encoding.default_external = "utf-8"

module MemoryDictionary
  require_relative 'memory_dictionary/errors'
  require_relative 'memory_dictionary/word'
  require_relative 'memory_dictionary/dictionary'
  require_relative 'memory_dictionary/translator'
  require_relative 'memory_dictionary/version'

  # Returns the lib logger object
  def self.logger
    @logger || initialize_logger
  end

  # Initializes logger with MemoryDictionary setup
  def self.initialize_logger(log_target = STDOUT)
    oldlogger = @logger
    @logger = Logger.new(log_target)
    @logger.level = Logger::INFO
    @logger.progname = 'memory_dictionary'
    oldlogger.close if oldlogger && !$TESTING # don't want to close testing's STDOUT logging
    @logger
  end

end
