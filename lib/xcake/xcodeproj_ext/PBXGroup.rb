require 'xcodeproj'

module Xcodeproj
  class Project
    module Object
      class PBXGroup
        def child_for_path(path)
          unless path.kind_of?(Array)
            path = path.split('/').keep_if do |c|
              c != '.'
            end
          end

          child_name = path.shift
          child = children.find { |c| c.display_name == child_name }

          if child.nil?
            child = new_group(child_name)
            child.path = child_name
          end

          if path.empty?
            child
          else
            child.child_for_path(path)
          end
        end

        def dirname
          return '.' if parent.kind_of? Xcake::Xcode::Project
          return '.' if parent.kind_of? PBXProject
          return parent.dirname.to_s if kind_of? PBXVariantGroup

          if display_name
            "#{parent.dirname}/#{display_name}"
          else
            parent.dirname.to_s
          end
        end
      end
    end
  end
end
