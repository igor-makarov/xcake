require 'xcodeproj'

module Xcake
  module Xcode
    # Special subclass of the Xcodeproj::Project which adds capabilities and
    # helper methods xcake need
    #
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

      def object_version
        Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s
      end

      def archive_version
        Xcodeproj::Constants::LAST_KNOWN_ARCHIVE_VERSION.to_s
      end

      def classes
        {}
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

        product = products_group.new_product_ref_for_target(native_target.product_name, target.type)
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

      # Creates a new xcode file reference for a path
      #
      # @param [Pathname] path
      # =>                path of the file reference from the source root
      #
      # @return [PBXFileReference] new xcode file refrence
      #
      def file_reference_for_path(path)
        group = group_for_file_reference_path(path)
        group_path = Pathname.new group.dirname
        file_path = path.cleanpath.relative_path_from group_path

        ref = group.find_file_by_path file_path.to_s
        return ref if ref

        group.new_reference(file_path.to_s)
      end

      # Finds or Creates a new xcode group for a path
      #
      # @param [Pathname] path
      # =>                path of the group from the source root
      #
      # @return [PBXGroup] existing or new xcode group
      #
      def group_for_file_reference_path(path)
        group = variant_group_for_path(path)
        group ||= group_for_path(path)
        group
      end

      private

      # Creates or finds a new xcode variant group for a path
      #
      # @note this method will return nil if the path isn't a valid
      # variant group path
      #
      # @param [Pathname] path
      # =>                path of the variant group from the source root
      #
      # @return [PBXVariantGroup] existing or new xcode variant group
      #
      def variant_group_for_path(path)
        group_path = path.dirname.cleanpath
        base_name = group_path.basename

        return nil unless base_name.to_s.include?('.lproj')

        parent_group = group_for_path(group_path)

        group = parent_group[path.basename.to_s]

        unless group
          group = new(PBXVariantGroup)
          group.name = path.basename.to_s
          group.set_source_tree(:group)
          parent_group.children << group
        end

        group
      end

      def group_for_path(path)
        group_path = path.dirname.cleanpath

        return main_group unless group_path.to_s != '.'

        main_group.child_for_path(group_path.to_s)
      end

      public

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

      # Finds a ui test target for a xcode target
      #
      # @param [Target] target
      #                 target to find a xcode target for.
      #
      # @return [Target] ui test target
      #
      def find_ui_test_target_for_target(target)
        targets.find do |t|
          t.name == "#{target.name}UITests"
        end
      end
    end
  end
end
