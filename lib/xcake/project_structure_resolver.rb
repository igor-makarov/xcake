module Xcake
  class ProjectStructureResolver

    include Visitor

    attr_accessor :cakefile

    def visit_cakefile(cakefile)

      puts "Resolving Project..."

      @cakefile = cakefile

      @cakefile.debug_build_configuration :debug if @cakefile.debug_build_configurations.count == 0
      @cakefile.release_build_configuration :release if @cakefile.release_build_configurations.count == 0
    end

    def leave_cakefile(cakefile)
    end

    def visit_target(target)

      puts "Resolving target #{target.name}..."

      @cakefile.debug_build_configurations.each do |b|
        target.debug_build_configuration(b.name)
      end

      @cakefile.release_build_configurations.each do |b|
        target.release_build_configuration(b.name)
      end
    end

    def leave_target(target)
    end

    def visit_buildconfiguration(configuration)
    end

    def leave_buildconfiguration(configuration)
    end
  end
end
