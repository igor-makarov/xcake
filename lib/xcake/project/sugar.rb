require "xcodeproj"

module Xcake
  class Project
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
    def application_for(platform, deployment_target, language = :objc, &block)
      target do |t|
        t.type = :application
        t.platform = platform
        t.deployment_target = deployment_target
        t.language = language

        block.call(t) if block_given?
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
    def unit_tests_for(host_target, &block)
      target do |t|
        t.name = "#{host_target.name}Tests"

        t.type = :unit_test_bundle
        t.platform = host_target.platform
        t.deployment_target = host_target.deployment_target
        t.language = host_target.language

        t.all_configurations.settings["TEST_HOST"] = "$(BUILT_PRODUCTS_DIR)/#{host_target.name}.app/#{host_target.name}"
        t.all_configurations.settings["BUNDLE_LOADER"] = "$(TEST_HOST)"

        t.target_dependencies = [host_target]
        host_target.testing_target = t

        block.call(t) if block_given?
      end
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
    def watch_app_for(host_target, deployment_target, language = :objc, &block)

      watch_extension_target = target do |t|
        t.name = "#{host_target.name}-Watch Extension"

        t.type = :watch2_extension
        t.platform = :watchos
        t.deployment_target = deployment_target
        t.language = language
      end

      watch_app_target = target do |t|
        t.name = "#{host_target.name}-Watch"

        t.type = :watch2_app
        t.platform = :watchos
        t.deployment_target = deployment_target
        t.language = language
      #  t.target_dependencies = [watch_extension_target]

      #  host_target.target_dependencies << t
      end

      block.call(watch_app_target, watch_extension_target) if block_given?

      return nil
    end
  end
end
