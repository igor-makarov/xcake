module Xcake
  class BuildConfiguration

    attr_accessor :name
    attr_accessor :settings

    def initialize(name, &block)
      self.name = name.to_s
      self.settings = {}

      block.call(self) if block_given?
    end

    def default_settings
    {
          'ALWAYS_SEARCH_USER_PATHS'           => 'NO',
          'CLANG_CXX_LANGUAGE_STANDARD'        => 'gnu++0x',
          'CLANG_CXX_LIBRARY'                  => 'libc++',
          'CLANG_ENABLE_OBJC_ARC'              => 'YES',
          'CLANG_WARN_BOOL_CONVERSION'         => 'YES',
          'CLANG_WARN_CONSTANT_CONVERSION'     => 'YES',
          'CLANG_WARN_DIRECT_OBJC_ISA_USAGE'   => 'YES',
          'CLANG_WARN__DUPLICATE_METHOD_MATCH' => 'YES',
          'CLANG_WARN_EMPTY_BODY'              => 'YES',
          'CLANG_WARN_ENUM_CONVERSION'         => 'YES',
          'CLANG_WARN_INT_CONVERSION'          => 'YES',
          'CLANG_WARN_OBJC_ROOT_CLASS'         => 'YES',
          'CLANG_WARN_UNREACHABLE_CODE'        => 'YES',
          'CLANG_ENABLE_MODULES'               => 'YES',
          'GCC_C_LANGUAGE_STANDARD'            => 'gnu99',
          'GCC_WARN_64_TO_32_BIT_CONVERSION'   => 'YES',
          'GCC_WARN_ABOUT_RETURN_TYPE'         => 'YES',
          'GCC_WARN_UNDECLARED_SELECTOR'       => 'YES',
          'GCC_WARN_UNINITIALIZED_AUTOS'       => 'YES',
          'GCC_WARN_UNUSED_FUNCTION'           => 'YES',
          'GCC_WARN_UNUSED_VARIABLE'           => 'YES',
        }
    end

    def debug_settings
      default_settings.merge({
          'ONLY_ACTIVE_ARCH'                   => 'YES',
          'COPY_PHASE_STRIP'                   => 'NO',
          'GCC_DYNAMIC_NO_PIC'                 => 'NO',
          'GCC_OPTIMIZATION_LEVEL'             => '0',
          'GCC_PREPROCESSOR_DEFINITIONS'       => ['DEBUG=1', '$(inherited)'],
          'GCC_SYMBOLS_PRIVATE_EXTERN'         => 'NO',
      })
    end

    def release_settings
      default_settings.merge({
          'COPY_PHASE_STRIP'                   => 'YES',
          'ENABLE_NS_ASSERTIONS'               => 'NO',
          'VALIDATE_PRODUCT'                   => 'YES',
      })
    end

    #TODO: Implement Build Configurations

        # def self.common_build_settings(type, platform = nil, deployment_target = nil, target_product_type = nil, language = :objc)
        #     target_product_type = (Constants::PRODUCT_TYPE_UTI.find { |_, v| v == target_product_type } || [target_product_type || :application])[0]
        #     common_settings = Constants::COMMON_BUILD_SETTINGS
        #
        #     if deployment_target
        #       case platform
        #       when :ios then settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        #       when :osx then settings['MACOSX_DEPLOYMENT_TARGET'] = deployment_target
        #       when :watchos then settings['WATCHOS_DEPLOYMENT_TARGET'] = deployment_target
        #       end
        #     end
        #
        #     settings
        #   end

        # COMMON_BUILD_SETTINGS = {
        #   :all => {
        #     'PRODUCT_NAME'                      => '$(TARGET_NAME)',
        #     'ENABLE_STRICT_OBJC_MSGSEND'        => 'YES',
        #   }.freeze,
        #   [:debug] => {
        #     'MTL_ENABLE_DEBUG_INFO'             => 'YES',
        #   }.freeze,
        #   [:release] => {
        #     'MTL_ENABLE_DEBUG_INFO'             => 'NO',
        #   }.freeze,
        #   [:ios] => {
        #     'SDKROOT'                           => 'iphoneos',
        #   }.freeze,
        #   [:osx] => {
        #     'SDKROOT'                           => 'macosx',
        #   }.freeze,
        #   [:watchos] => {
        #     'SDKROOT'                           => 'watchos',
        #   }.freeze,
        #   [:debug, :osx] => {
        #     # Empty?
        #   }.freeze,
        #   [:release, :osx] => {
        #     'DEBUG_INFORMATION_FORMAT'          => 'dwarf-with-dsym',
        #   }.freeze,
        #   [:debug, :ios] => {
        #     # Empty?
        #   }.freeze,
        #   [:debug, :application, :swift] => {
        #     'SWIFT_OPTIMIZATION_LEVEL'          => '-Onone',
        #     'ENABLE_TESTABILITY'                => 'YES',
        #   }.freeze,
        #   [:debug, :dynamic_library, :swift] => {
        #     'ENABLE_TESTABILITY'                => 'YES',
        #   }.freeze,
        #   [:debug, :framework, :swift] => {
        #     'ENABLE_TESTABILITY'                => 'YES',
        #   }.freeze,
        #   [:debug, :static_library, :swift] => {
        #     'ENABLE_TESTABILITY'                => 'YES',
        #   }.freeze,
        #   [:framework] => {
        #     'VERSION_INFO_PREFIX'               => '',
        #     'DYLIB_COMPATIBILITY_VERSION'       => '1',
        #     'DEFINES_MODULE'                    => 'YES',
        #     'DYLIB_INSTALL_NAME_BASE'           => '@rpath',
        #     'CURRENT_PROJECT_VERSION'           => '1',
        #     'VERSIONING_SYSTEM'                 => 'apple-generic',
        #     'DYLIB_CURRENT_VERSION'             => '1',
        #     'SKIP_INSTALL'                      => 'YES',
        #     'INSTALL_PATH'                      => '$(LOCAL_LIBRARY_DIR)/Frameworks',
        #   }.freeze,
        #   [:ios, :framework] => {
        #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/Frameworks', '@loader_path/Frameworks'],
        #     'CODE_SIGN_IDENTITY[sdk=iphoneos*]' => 'iPhone Developer',
        #     'TARGETED_DEVICE_FAMILY'            => '1,2',
        #   }.freeze,
        #   [:osx, :framework] => {
        #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/../Frameworks', '@loader_path/Frameworks'],
        #     'FRAMEWORK_VERSION'                 => 'A',
        #     'COMBINE_HIDPI_IMAGES'              => 'YES',
        #   }.freeze,
        #   [:framework, :swift] => {
        #     'DEFINES_MODULE'                    => 'YES',
        #   }.freeze,
        #   [:debug, :framework, :swift] => {
        #     'SWIFT_OPTIMIZATION_LEVEL'          => '-Onone',
        #   }.freeze,
        #   [:osx, :static_library] => {
        #     'EXECUTABLE_PREFIX'                 => 'lib',
        #   }.freeze,
        #   [:ios, :static_library] => {
        #     'OTHER_LDFLAGS'                     => '-ObjC',
        #     'SKIP_INSTALL'                      => 'YES',
        #   }.freeze,
        #   [:osx, :dynamic_library] => {
        #     'EXECUTABLE_PREFIX'                 => 'lib',
        #     'DYLIB_COMPATIBILITY_VERSION'       => '1',
        #     'DYLIB_CURRENT_VERSION'             => '1',
        #   }.freeze,
        #   [:application] => {
        #     'ASSETCATALOG_COMPILER_APPICON_NAME' => 'AppIcon',
        #   }.freeze,
        #   [:ios, :application] => {
        #     'CODE_SIGN_IDENTITY[sdk=iphoneos*]' => 'iPhone Developer',
        #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/Frameworks'],
        #   }.freeze,
        #   [:osx, :application] => {
        #     'COMBINE_HIDPI_IMAGES'              => 'YES',
        #     'CODE_SIGN_IDENTITY'                => '-',
        #     'LD_RUNPATH_SEARCH_PATHS'           => ['$(inherited)', '@executable_path/../Frameworks'],
        #   }.freeze,
        #   [:bundle] => {
        #     'PRODUCT_NAME'                      => '$(TARGET_NAME)',
        #     'WRAPPER_EXTENSION'                 => 'bundle',
        #     'SKIP_INSTALL'                      => 'YES',
        #   }.freeze,
        #   [:ios, :bundle] => {
        #     'SDKROOT'                           => 'iphoneos',
        #   }.freeze,
        #   [:osx, :bundle] => {
        #     'COMBINE_HIDPI_IMAGES'              => 'YES',
        #     'SDKROOT'                           => 'macosx',
        #     'INSTALL_PATH'                      => '$(LOCAL_LIBRARY_DIR)/Bundles',
        #   }.freeze,
        # }.freeze
        #

    def debug_settings_for_target(t)
    end

    def release_settings_for_target(t)
    end
  end
end
