require "xcake/core_ext/string"

require "xcake/version"
require "xcake/ui"
require "xcake/informative"
require "xcake/command"

require "xcake/dependency"
require "xcake/dependency_provider"
require "xcake/plugin"
require "xcake/visitable"
require "xcake/visitor"
require "xcake/generator"
require "xcake/context"
require "xcake/context/xcodeproj_context"

require "xcake/configuration"
require "xcake/configuration/sugar"
require "xcake/configuration/proxies/preproccessor_definitions_setting_proxy"
require "xcake/configurable"

require "xcake/project"
require "xcake/project/sugar"
require "xcake/project/hooks"
require "xcake/file_reference_installer"
require "xcake/node"
require "xcake/shell_script_build_phase"
require "xcake/target"
require "xcake/target/sugar"

require "xcake/xcode/project"
require "xcake/xcode/scheme"
require "xcake/xcode/scheme_list"

#TODO: Autoload these
require "xcake/generator/project_generator"
require "xcake/generator/project_structure_generator"
require "xcake/generator/scheme_generator"
require "xcake/generator/target_generator"
require "xcake/generator/target_framework_generator"
require "xcake/generator/target_file_reference_generator"
require "xcake/generator/target_custom_build_phase_generator"
require "xcake/generator/configuration_generator"

require "xcake/file_reference_installer/compile_source_file_reference_installer"
require "xcake/file_reference_installer/compile_xcdatamodeld_file_reference_installer"
require "xcake/file_reference_installer/copy_resources_file_reference_installer"
require "xcake/file_reference_installer/copy_xcassets_file_reference_installer"
require "xcake/file_reference_installer/header_file_reference_installer"

module Xcake

end
