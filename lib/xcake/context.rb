require 'xcodeproj'

module Xcake
  # The Context is an object that tracking of native objects in the project
  # format.
  #
  # It allows components of the Xcake generator system to retrieve the
  # native representation of a DSL object which is useful for operations
  # which require multiple steps.
  #
  # See XcodeprojContext and the Genrators for how this is used.
  #
  module Context
    # The internal hash of native objects reference by their
    # related DSL object
    #
    def object_hash
      @object_hash ||= {}
    end

    # This method returns or creates a native object
    # for a DSL object
    #
    def native_object_for(dsl_object)
      object_hash[dsl_object] ||= create_object_for(dsl_object)
    end

    # This method returns or creates a file reference
    # for a path
    #
    def file_reference_for_path(path)
    end

    # This method returns or creates a scheme list for
    # the project
    #
    def scheme_list
    end
  end
end
