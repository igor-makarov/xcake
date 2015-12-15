module Xcake
  class Project

    private
    attr_accessor :after_hooks

    def after_hook(block)
      @after_hooks ||= []
      after_hook << block
    end

    def call_after_hooks
      @after_hooks.each do |block|
        block.call(self) if block_given?
      end
    end

  end
end
