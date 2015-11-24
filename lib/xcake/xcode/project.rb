require 'xcodeproj'

module Xcake
  module Xcode
    class Project < Xcodeproj::Project

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

        def object_version
          Xcodeproj::Constants::DEFAULT_OBJECT_VERSION.to_s
        end

        def new_target(target)
          native_target = self.new(Xcodeproj::Project::Object::PBXNativeTarget)
          native_target.name = target.name
          native_target.product_name = target.name
          native_target.product_type = Xcodeproj::Constants::PRODUCT_TYPE_UTI[target.type]
          native_target.build_configuration_list = self.new(Xcodeproj::Project::Object::XCConfigurationList)

          product = self.products_group.new_product_ref_for_target(native_target.product_name, native_target.product_type)
          native_target.product_reference = product

          self.targets << native_target
          native_target
        end

        def scheme_list
          @scheme_list ||= SchemeList.new
        end

        def recreate_user_schemes(visible = true)

          puts "Creating Schemes..."

          targets.each do |t|
            recreate_schemes_for_target(t, visible)
          end

          scheme_list.save(path)
        end

        def recreate_schemes_for_target(target, visible = true)
          #t.build_configuration_list.build_configurations.each do |c|

          #end
          #target.product_type = Constants::PRODUCT_TYPE_UTI[type]
          #scheme = Xcodeproj::XCScheme.new

          #   puts "Writing Scheme #{s.name}.."
          #   s.save_as(path, s.name, true)
          #
          #   xcschememanagement['SchemeUserState']["#{s.name}.xcscheme"] = {}
          #   xcschememanagement['SchemeUserState']["#{s.name}.xcscheme"]['isShown'] = true
        end
    end
  end
end
