require 'xcake/core_ext/array'
require 'xcake/core_ext/object'
require 'xcake/core_ext/string'
require 'xcake/xcodeproj_ext/PBXGroup'
require 'xcake/xcodeproj_ext/PBXNativeTarget'
require 'xcake/modern_xcodeproj.rb'

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

require 'xcake/xcode/project'
require 'xcake/xcode/scheme'
require 'xcake/xcode/scheme_list'

module Xcake
end
