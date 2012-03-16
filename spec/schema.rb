ActiveRecord::Schema.define :version => 0 do

  create_table :taggable_models, :force => true do |t|
    t.column :name, :string
    t.column :type, :string
  end

  add_column :taggable_models, :tag_hstore, :hstore

  execute "create index concurrently idx_tag_model_tag_hstore on taggable_models using gist (tag_hstore)"

  create_table :untaggable_models, :force => true do |t|
    t.column :name, :string
  end

end