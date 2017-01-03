require 'xcake/core_ext/array'
require 'xcake/core_ext/object'
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

require 'xcake/context'
require 'xcake/context/xcodeproj_context'

require 'xcake/configuration'
require 'xcake/configuration/sugar'
require 'xcake/configuration/proxies/preproccessor_definitions_setting_proxy'
require 'xcake/configurable'

require 'xcake/project'
require 'xcake/project/sugar'
require 'xcake/project/hooks'
require 'xcake/path_classifier'

require 'xcake/target'
require 'xcake/target/sugar'
require 'xcake/target/configurable'

require 'xcake/build_phase'
require 'xcake/build_phase/headers_build_phase'
require 'xcake/build_phase/shell_script_build_phase'

module Xcake
end
