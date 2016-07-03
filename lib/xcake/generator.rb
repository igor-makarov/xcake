module Xcake
  class Generator
    include Dependency
    include Plugin
    include Visitor

    attr_accessor :context

    def initialize(context)
      self.context = context
    end

    def self.plugins_location
      "#{File.dirname(__FILE__)}/generator/*.rb"
    end
  end
end
