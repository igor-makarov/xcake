require 'xcodeproj'

module Xcake
  module Context
    attr_accessor :object_hash

    def object_hash
      @object_hash ||= {}
    end

    def native_object_for(dsl_object)
      object_hash[dsl_object] ||= create_object_for(dsl_object)
    end

    def file_reference_for_path(path)
    end

    def scheme_list
    end
  end
end
