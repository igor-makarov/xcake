require 'active_support/core_ext/hash/deep_merge'

module Xcake
  module Constants
    COMMON_BUILD_SETTINGS = Xcodeproj::Constants::COMMON_BUILD_SETTINGS.dup.deep_merge(
      [:ios, :unit_test_bundle] => {
        'LD_RUNPATH_SEARCH_PATHS' => [
          '$(inherited)',
          '@executable_path/Frameworks',
          '@loader_path/Frameworks'
        ]
      }.freeze,
      [:ios, :ui_test_bundle] => {
        'LD_RUNPATH_SEARCH_PATHS' => [
          '$(inherited)',
          '@executable_path/Frameworks',
          '@loader_path/Frameworks'
        ]
      }.freeze,
      [:osx, :unit_test_bundle] => {
        'LD_RUNPATH_SEARCH_PATHS' => [
          '$(inherited)',
          '@executable_path/../Frameworks',
          '@loader_path/../Frameworks'
        ]
      }.freeze,
      [:osx, :ui_test_bundle] => {
        'LD_RUNPATH_SEARCH_PATHS' => [
          '$(inherited)',
          '@executable_path/../Frameworks',
          '@loader_path/../Frameworks'
        ]
      }.freeze
    ).freeze

    PRODUCT_TYPE_UTI = Xcodeproj::Constants::PRODUCT_TYPE_UTI

    COPY_FILES_BUILD_PHASE_DESTINATIONS = Xcodeproj::Constants::COPY_FILES_BUILD_PHASE_DESTINATIONS

    # Returns the common build settings for a given platform and configuration
    # name.
    #
    # @param  [Symbol] type
    #         the type of the build configuration, can be `:release` or
    #         `:debug`.
    #
    # @param  [Symbol] platform
    #         the platform for the build settings, can be `:ios` or `:osx`.
    #
    # @param  [String] deployment_target
    #         the deployment target for the platform.
    #
    # @param  [Symbol] target_product_type
    #         the product type of the target, can be any of
    #         `Constants::PRODUCT_TYPE_UTI.values`
    #         or `Constants::PRODUCT_TYPE_UTI.keys`. Default is :application.
    #
    # @param  [Symbol] language
    #         the primary language of the target, can be `:objc` or `:swift`.
    #
    # @return [Hash] The common build settings
    #
    def self.common_build_settings(type, platform = nil, deployment_target = nil, target_product_type = nil, language = :objc) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/LineLength
      target_product_type = (PRODUCT_TYPE_UTI.find { |_, v| v == target_product_type } || [target_product_type || :application])[0] # rubocop:disable Metrics/LineLength
      common_settings = COMMON_BUILD_SETTINGS

      # Use intersecting settings for all key sets as base
      settings = deep_dup(common_settings[:all])

      # Match further common settings by key sets
      keys = [type, platform, target_product_type, language].compact
      key_combinations = (1..keys.length).flat_map { |n| keys.combination(n).to_a }
      key_combinations.each do |key_combination|
        settings.merge!(deep_dup(common_settings[key_combination] || {}))
      end

      if deployment_target
        case platform
        when :ios then settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        when :osx then settings['MACOSX_DEPLOYMENT_TARGET'] = deployment_target
        when :tvos then settings['TVOS_DEPLOYMENT_TARGET'] = deployment_target
        when :watchos then settings['WATCHOS_DEPLOYMENT_TARGET'] = deployment_target
        end
      end

      settings
    end

    # Creates a deep copy of the given object
    #
    # @param  [Object] object
    #         the object to copy.
    #
    # @return [Object] The deeply copy of the obejct object.
    #
    def self.deep_dup(object)
      Xcodeproj::Project::ProjectHelper.deep_dup(object)
    end
  end
end
