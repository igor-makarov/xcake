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
  end
end
