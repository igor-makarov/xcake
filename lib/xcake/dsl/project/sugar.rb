require 'xcodeproj'

module Xcake
  class Project
    # Passes the project instance to a block. This is used to easily modify the
    # properties of the project in the DSL.
    #
    #
    # @param  [Proc] block
    #         an optional block that configures the project through the DSL.
    #
    def project
      yield(self) if block_given?
      self
    end

    # Defines a new application target.
    #
    # @param  [Symbol] platform
    #         platform for the application, can be either `:ios`, `:osx`, `:tvos` or `:watchos`.
    #
    # @param  [Float] deployment_target
    #         the minimum deployment version for the platform.
    #
    # @param  [Symbol] language
    #         language for application, can be either `:objc` or `:swift`.
    #
    # @param  [Proc] block
    #         an optional block that configures the target through the DSL.
    #
    # @return [Target] the application target
    #         the newly created application target
    #
    def application_for(platform, deployment_target, language = :objc)
      target do |t|
        t.type = :application
        t.platform = platform
        t.deployment_target = deployment_target
        t.language = language

        yield(t) if block_given?
      end
    end

    # Defines a new ui test target.
    #
    # @param  [Target] host target
    #         host target for which the unit tests are for.
    #
    # @param  [Proc] block
    #         an optional block that configures the target through the DSL.
    #
    # @return [Target] the unit test target
    #         the newly created unit test target
    #
    def ui_tests_for(host_target)
      target do |t|
        t.name = "#{host_target.name}UITests"

        t.type = :ui_test_bundle
        configure_test_target_for_host_target(t, host_target)

        yield(t) if block_given?
      end
    end

    # Defines a new unit test target.
    #
    # @param  [Target] host target
    #         host target for which the unit tests are for.
    #
    # @param  [Proc] block
    #         an optional block that configures the target through the DSL.
    #
    # @return [Target] the unit test target
    #         the newly created unit test target
    #
    def unit_tests_for(host_target)
      target do |t|
        t.name = "#{host_target.name}Tests"

        t.type = :unit_test_bundle
        configure_test_target_for_host_target(t, host_target)

        yield(t) if block_given?
      end
    end

    private

    def configure_test_target_for_host_target(test_target, host_target)
      test_target.target_dependencies << host_target
      test_target.platform = host_target.platform
      test_target.deployment_target = host_target.deployment_target
      test_target.language = host_target.language

      return unless host_target.type == :application

      test_target.all_configurations.each do |c|
        # Do nothing as they break UITests
        # For more details https://github.com/jcampbell05/xcake/issues/115
        next if test_target.type == :ui_test_bundle

        c.settings['BUNDLE_LOADER'] = '$(TEST_HOST)'
        c.settings['TEST_HOST'] = if host_target.platform == :osx
                                    "$(BUILT_PRODUCTS_DIR)/#{host_target.name}.app/Contents/MacOS/#{host_target.name}"
                                  else
                                    "$(BUILT_PRODUCTS_DIR)/#{host_target.name}.app/#{host_target.name}"
                                  end
      end
    end

    public

    # Defines a extension target.
    #
    # @param  [Target] host target
    #         host target for which the extension is for.
    #
    # @param  [Proc] block
    #         an optional block that configures the target through the DSL.
    #
    # @return [Target] the extension target
    #         the newly created extension target
    #
    def extension_for(host_target)
      target = target do |t|
        t.type = :app_extension
        t.platform = host_target.platform
        t.deployment_target = host_target.deployment_target
        t.language = host_target.language
      end

      host_target.target_dependencies << target

      yield(target) if block_given?

      target
    end

    # Defines targets for watch app.
    #
    # @param  [Target] watch app's compantion app
    #         iOS target for the watch app
    #
    # @param  [Proc] block
    #         an optional block that configures the targets through the DSL.
    #
    # @return Void
    #
    def watch_app_for(host_target, deployment_target, language = :objc)
      watch_app_target = target do |t|
        t.name = "#{host_target.name}-Watch"

        t.type = :watch2_app
        t.platform = :watchos
        t.deployment_target = deployment_target
        t.language = language
      end

      watch_extension_target = target do |t|
        t.name = "#{host_target.name}-Watch Extension"

        t.type = :watch2_extension
        t.platform = :watchos
        t.deployment_target = deployment_target
        t.language = language
      end

      host_target.target_dependencies << watch_app_target
      watch_app_target.target_dependencies << watch_extension_target

      yield(watch_app_target, watch_extension_target) if block_given?

      nil
    end
  end
end
