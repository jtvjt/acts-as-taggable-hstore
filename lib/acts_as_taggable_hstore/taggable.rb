module ActsAsTaggableHstore
  module Taggable
    def taggable?
      false
    end
    def acts_as_taggable_hstore
      acts_as_taggable_hstore_by ActsAsTaggableHstore.default_column
    end

    def acts_as_taggable_hstore_by(*column_name)

      class_attribute :tag_hstore_column
      self.tag_hstore_column = column_name.first

      class_eval do
        def self.taggable?
          true
        end
        include ActsAsTaggableHstore::Taggable::Core
      end
    end
  end
end