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
        attributes['CLASSPREFIX']
      end

      # Sets the class prefix for the project
      #
      # @param [String] value to set
      #
      # @return [String] the class name for the project
      #
      def class_prefix=(class_prefix)
        attributes['CLASSPREFIX'] = class_prefix
      end

      # @return [String] the organization for the project
      #
      def organization
        attributes['ORGANIZATIONNAME']
      end

      # Sets the organization for the project
      #
      # @param [String] value to set
      #
      # @return [SchemeList] the organization for the project
      #
      def organization=(organization)
        attributes['ORGANIZATIONNAME'] = organization
      end

      # @return [SchemeList] the scheme list
      #
      def scheme_list
        @scheme_list ||= SchemeList.new(self)
      end

      def object_version
        Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s
      end

      def recreate_user_schemes(*)
        scheme_list.recreate_schemes
        scheme_list.save(path)
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
      # @return [Target] new xcode target
      #
      def new_target(target)
        native_target = new(Xcodeproj::Project::Object::PBXNativeTarget)
        native_target.name = target.name
        native_target.product_name = target.name

        case target.type
        when Symbol
          native_target.product_type = Xcodeproj::Constants::PRODUCT_TYPE_UTI[target.type]
        when String
          native_target.product_type = target.type
        end

        native_target.build_configuration_list = new(Xcodeproj::Project::Object::XCConfigurationList)

        product = products_group.new_product_ref_for_target(native_target.product_name, native_target.product_type)
        native_target.product_reference = product

        targets << native_target
        native_target
      end

      # Creates a new xcode configuration from the configuration DSL
      #
      # @param [Configurarion] configuration
      #                 configuration DSL to create target from
      #
      # @return [Configurarion] new xcode configuration
      #
      def new_configuration(_configuration)
        new(Xcodeproj::Project::Object::XCBuildConfiguration)
      end

      # Creates a new xcode file reference from the node
      #
      # @param [Pathname] path
      # =>                path of the file reference from the source root
      #
      # @return [PBXFileReference] new xcode file refrence
      #
      def file_reference_for_path(path)
        return if File.directory?(path)

        group = group_for_file_reference_path(path)

        group_path = Pathname.new ".#{group.hierarchy_path}"
        real_group_path = group_path.dirname.cleanpath
        file_path = path.cleanpath.relative_path_from real_group_path
        group.new_reference(file_path.to_s)
      end

      def group_for_file_reference_path(path)
        clean_path = path.cleanpath
        group = variant_group_for_path(path)
        group = group_for_path(path) unless group
        group
      end

      def variant_group_for_path(path)
        group_path = path.dirname.cleanpath
        base_name = group_path.basename

        return nil unless base_name.to_s.include?('.lproj')
        parent_group = group_for_path(group_path)

        group = new(PBXVariantGroup)
        group.name = path.basename.to_s
        group.set_source_tree(:group)
        parent_group.children << group

        group
      end

      def group_for_path(path)
        return main_group unless path != '.'
        return main_group.child_for_path(path.dirname.to_s)
      end

      # Finds a unit test target for a xcode target
      #
      # @param [Target] target
      #                 target to find a xcode target for.
      #
      # @return [Target] unit test target
      #
      def find_unit_test_target_for_target(target)
        targets.find do |t|
          t.name == "#{target.name}Tests"
        end
      end
    end
  end
end
