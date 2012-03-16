require File.expand_path('../../spec_helper', __FILE__)

describe "Acts As Taggable Hstore" do
  before(:each) do
    clean_database!
  end

  it "should provide a class method 'taggable?' that is false for untaggable models" do
    UntaggableModel.should_not be_taggable
  end

  describe "Taggable Method Generation" do
    before(:each) do
      clean_database!
      @taggable = TaggableModel.new(:name => "Bob Jones")
    end

    it "should respond 'true' to taggable?" do
      @taggable.class.should be_taggable
    end

    it "should generate a tag_list accessor/setter for each tag type" do
      @taggable.should respond_to(:tag_list)
      @taggable.should respond_to(:tag_list=)
    end

    it "should have a hstore sql type" do
      @taggable.class.columns_hash[@taggable.class.tag_hstore_column.to_s].sql_type.should == "hstore"
    end

    it "should make strings have valid_hstore" do
      "bob".valid_hstore?.should == false
    end

    it "should have a hstore column type" do
      @taggable.class.columns_hash[@taggable.class.tag_hstore_column.to_s].type.should == :hstore
    end

  end

  describe "Reloading" do
    it "should save a model instantiated by Model.find" do
      taggable = TaggableModel.create!(:name => "Taggable")
      found_taggable = TaggableModel.find(taggable.id)
      found_taggable.save
    end
  end
end