require "xcake/core_ext/string"

require "xcake/visitable"
require "xcake/visitor"
require "xcake/version"

require "xcake/command"
require "xcake/configuration"
require "xcake/configuration/sugar"
require "xcake/configuration/proxies/preproccessor_definitions_setting_proxy"
require "xcake/configurable"

require "xcake/generator/build_phase"
require "xcake/generator/build_phase/compile_source_build_phase"
require "xcake/generator/build_phase/copy_resources_build_phase"
require "xcake/generator/build_phase/copy_xcassets_build_phase"
require "xcake/generator/build_phase/header_file_build_phase"
require "xcake/generator/build_phase_registry"

require "xcake/generator/configuration"
require "xcake/generator/path"
require "xcake/generator/project"
require "xcake/generator/target"

require "xcake/project"
require "xcake/project/sugar"
require "xcake/project/hooks"
require "xcake/project_structure_resolver"
require "xcake/node"
require "xcake/target"

require "xcake/xcode/project"
require "xcake/xcode/scheme"
require "xcake/xcode/scheme_list"

module Xcake
  # Indicates an user error. This is defined in command.rb.
  #
  class Informative < Command::PlainInformative
    def message
      "[!] #{super}"
    end
  end
end
