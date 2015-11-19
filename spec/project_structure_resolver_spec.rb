require 'spec_helper'

module Xcake
  describe ProjectStructureResolver do

    # def visit_cakefile(cakefile)
    #
    #   puts "Resolving Project..."
    #
    #   @cakefile = cakefile
    #
    #   @cakefile.debug_build_configuration :debug if @cakefile.debug_build_configurations.count == 0
    #   @cakefile.release_build_configuration :release if @cakefile.release_build_configurations.count == 0
    # end
    # 
    # def visit_target(target)
    #
    #   puts "Resolving target #{target.name}..."
    #
    #   @cakefile.debug_build_configurations.each do |b|
    #     target.debug_build_configuration(b.name)
    #   end
    #
    #   @cakefile.release_build_configurations.each do |b|
    #     target.release_build_configuration(b.name)
    #   end
    # end
  end
end
