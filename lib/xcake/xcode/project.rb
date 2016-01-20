require 'xcodeproj'

module Xcake
  module Xcode
    class Project < Xcodeproj::Project

        # @return [Hash] the attributes of
        #                the project
        #
        def attributes
          root_object.attributes
        end

        # @return [String] the class name for the project
        #
        def class_prefix
          attributes["CLASSPREFIX"]
        end

        # Sets the class prefix for the project
        #
        # @param [String] value to set
        #
        # @return [String] the class name for the project
        #
        def class_prefix=(class_prefix)
          attributes["CLASSPREFIX"] = class_prefix
        end

        # @return [String] the organization for the project
        #
        def organization
          attributes["ORGANIZATIONNAME"]
        end

        # Sets the organization for the project
        #
        # @param [String] value to set
        #
        # @return [SchemeList] the organization for the project
        #
        def organization=(organization)
          attributes["ORGANIZATIONNAME"] = organization
        end

        def object_version
          Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s
        end

        # Configures the Project for use with Xcake.
        # This makes sure we have sensible defaults and
        # it as clean as possible.
        #
        def setup_for_xcake
          root_object.remove_referrer(self) if root_object
          root_object = new(Project::Object::PBXProject)
          root_object.add_referrer(self)

          config_list = new(XCConfigurationList)
          root_object.build_configuration_list = config_list

          root_object.main_group = new(PBXGroup)
          root_object.product_ref_group = root_object.main_group.new_group('Products')

          @root_object = root_object
        end

        # Creates a new xcode target from the target DSL
        #
        # @param [Target] target
        #                 target DSL to create target from
        #
        # @return [PBXNativeTarget] new xcode target
        #
        def new_target(target)
          native_target = self.new(Xcodeproj::Project::Object::PBXNativeTarget)
          native_target.name = target.name
          native_target.product_name = target.name

          case target.type
          when Symbol
            native_target.product_type = Xcodeproj::Constants::PRODUCT_TYPE_UTI[target.type]
          when String
            native_target.product_type = target.type
          end

          native_target.build_configuration_list = self.new(Xcodeproj::Project::Object::XCConfigurationList)

          product = self.products_group.new_product_ref_for_target(native_target.product_name, native_target.product_type)
          native_target.product_reference = product

          self.targets << native_target
          native_target
        end
    end
  end
end
