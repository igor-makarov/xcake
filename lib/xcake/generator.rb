module Xcake
  class Generator

    include Dependency
    include Plugin
    include Visitor

    attr_accessor :context

    def initialize(context)
      self.context = context
    end
  end
end
