module Xcake
  class TargetFileReferenceGenerator < Generator
    attr_accessor :root_node
    attr_accessor :dependency_provider

    def initialize(context)
      @context = context
      @root_node = Node.new

      @dependency_provider = DependencyProvider.new(FileReferenceInstaller)
    end

    def self.dependencies
      [TargetGenerator]
    end

    def process_files_for_target(target)
      native_target = @context.native_object_for(target)

      Dir.glob(target.include_files).each do |file|
        @root_node.create_children_with_path(file, native_target)
      end if target.include_files

      Dir.glob(target.exclude_files).each do |file|
        @root_node.remove_children_with_path(file, native_target)
      end if target.exclude_files
    end

    def visit_project(project)
      project.targets.each do |target|
        process_files_for_target(target)
      end

      root_node.accept(self)
    end

    def visit_node(node)
      return unless node.path

      EventHooks.run_hook :before_adding_file, node

      installer_class = @dependency_provider.tsort.detect do |i|
        i.can_install_node(node)
      end

      unless installer_class.nil?
        installer = installer_class.new(context)
        node.accept(installer)
      end
    end
  end
end
