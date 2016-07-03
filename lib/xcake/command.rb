require 'claide'

module Xcake
  class Command < CLAide::Command
    require 'xcake/command/init'
    require 'xcake/command/make'

    self.abstract_command = true
    self.command = 'xcake'
    self.version = VERSION
    self.description = 'Create and maintain Xcode project files easily.'
    self.plugin_prefixes = %w(claide xcake)
  end
end
