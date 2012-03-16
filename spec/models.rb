class TaggableModel < ActiveRecord::Base
  acts_as_taggable_hstore
end

class UntaggableModel < ActiveRecord::Base
end