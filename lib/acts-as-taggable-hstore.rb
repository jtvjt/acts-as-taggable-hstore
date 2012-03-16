require "active_record"
require "active_record/version"
require "activerecord-postgres-hstore-core"

require "action_view"
require "digest/sha1"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsTaggableHstore
  mattr_accessor :delimiter
  @@delimiter = ','

  mattr_accessor :force_lowercase
  @@force_lowercase = false

  mattr_accessor :default_column
  @@default_column = :tag_hstore

  def self.glue
    @@delimiter.ends_with?(" ") ? @@delimiter : "#{@@delimiter} "
  end

  def self.setup
    yield self
  end
end

require "acts_as_taggable_hstore/taggable"
require "acts_as_taggable_hstore/acts_as_taggable_hstore/core"

$LOAD_PATH.shift

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend ActsAsTaggableHstore::Taggable
end