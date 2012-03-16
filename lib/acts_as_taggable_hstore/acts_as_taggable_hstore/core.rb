module ActsAsTaggableHstore::Taggable
  module Core
    def self.included(base)
      base.send :include, ActsAsTaggableHstore::Taggable::Core::InstanceMethods
      base.extend ActsAsTaggableHstore::Taggable::Core::ClassMethods
      
#      base.class_eval do
#         class_attribute :hstore_column
#      end
    end

    module ClassMethods
      #allow inheritence
      def acts_as_taggable_hstore_by(*args)
        super(*args)
      end

      def tagged_with(tag_list, options= {})
        empty_result = scoped(:conditions => "1 = 0")
        return empty_result if tag_list.blank?

        if tag_list.is_a? String
          tag_list = [tag_list]
        end

        connect_with = " AND "
        if options.delete(:any)
          connect_with = " OR "
        end

        conditions = []
        tag_list.each do |tag_name|
          conditions << self.tag_hstore_column.to_s + " ? '#{tag_name}' "
        end

        return where(conditions.join(connect_with))

      end

    end

    module InstanceMethods

      def tag_list
        hstore_result = self.send(self.class.tag_hstore_column)

        if hstore_result.nil?
          return []
        end

        return hstore_result.keys.join(ActsAsTaggableHstore.glue)
      end

      def tag_list=(tags)
        prep_hstore = tags.split(ActsAsTaggableHstore.delimiter).map(&:strip).inject({}) { |h,k| h[k] = nil; h }
        self.send(self.class.tag_hstore_column.to_s + "=", prep_hstore)
      end

      def tags
        tag_hstore.keys
      end

    end
  end
end