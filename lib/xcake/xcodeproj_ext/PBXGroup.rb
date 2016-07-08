require 'Xcodeproj'

module Xcodeproj
  class Project
    module Object
      class PBXGroup
        def child_for_path(path)
          path = path.split('/').keep_if do |c|
            c != '.'
          end unless path.is_a?(Array)

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
          return "./#{display_name}" if parent.is_a? Xcake::Xcode::Project
          return "./#{display_name}" if parent.is_a? PBXProject

          if display_name
            "#{parent.dirname.to_s}/#{display_name}"
          else
            parent.dirname.to_s
          end
        end
     end
   end
  end
end
