require 'xcake/core_ext/class'
require 'xcake/core_ext/string'

require 'xcake/xcode/project'
require 'xcake/xcode/scheme'
require 'xcake/xcode/scheme_list'

require 'xcake/xcodeproj_ext/PBXGroup'
require 'xcake/xcodeproj_ext/PBXNativeTarget'

require 'xcake/constants'
require 'xcake/modern_xcodeproj'
require 'xcake/version'
require 'xcake/event_hooks'
require 'xcake/ui'
require 'xcake/informative'
require 'xcake/command'

require 'xcake/dependency'
require 'xcake/dependency_provider'
require 'xcake/plugin'
require 'xcake/visitable'
require 'xcake/visitor'
require 'xcake/generator'
require 'xcake/path_classifier'

require 'xcake/context'
require 'xcake/context/xcodeproj_context'

require 'xcake/dsl/configuration'
require 'xcake/dsl/configuration/sugar'
require 'xcake/dsl/configuration/proxies/preproccessor_definitions_setting_proxy'
require 'xcake/dsl/configurable'

require 'xcake/dsl/project'
require 'xcake/dsl/project/sugar'
require 'xcake/dsl/project/hooks'

require 'xcake/dsl/scheme'

require 'xcake/dsl/target'
require 'xcake/dsl/target/sugar'
require 'xcake/dsl/target/configurable'

require 'xcake/dsl/build_rule'

require 'xcake/dsl/build_phase'
require 'xcake/dsl/build_phase/headers_build_phase'
require 'xcake/dsl/build_phase/shell_script_build_phase'
require 'xcake/dsl/build_phase/copy_files_build_phase'

module Xcake
end
