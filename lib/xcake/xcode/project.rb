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

      # Creates a new xcode group from the node
      #
      # @param [Node]   node
      #                 configuration DSL to create target from
      #
      # @return [Group] new xcode group
      #
      #
      # TODO: Simplify this method figure out more reliable rules for group
      # generation - maybe part of the new file installer in 0.7.
      #
      # As well as variant groups and other types of groups.
      #
      def new_group(node)

        parent = node.parent
        return main_group unless parent

        if parent.component.include?(".lproj")

          group = main_group.find_subpath(parent.parent.path, true) unless group

          variant_group = group[node.component]

          unless variant_group
            variant_group = group.project.new(PBXVariantGroup)
            variant_group.name = node.component
            variant_group.set_source_tree(:group)
            group.children << variant_group
          end

          ensure_parent_path(group, parent.parent)
          group = variant_group
        else
          group = main_group.find_subpath(parent.path, true) unless group
          ensure_parent_path(group, parent)
        end

        group
      end

      # Creates a new xcode file reference from the node
      #
      # @param [String] path
      # =>              path of the file reference from the source root
      #
      # @return [PBXFileReference] new xcode file refrence
      #
      def new_file_reference(path)
        path_object = Pathname.new(path)
        group = main_group.find_subpath(path_object.dirname.to_s, true)
        group[path_object.basename.to_s] ||
          group.new_reference(path_object.to_s)
      end

      def ensure_parent_path(group, node)
        group.path = node.component
        ensure_parent_path(group.parent, node.parent) unless node.parent.nil?
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
