require File.expand_path('../../spec_helper', __FILE__)

describe "Taggable" do
  before(:each) do
    clean_database!
    @taggable = TaggableModel.new(:name => "Bob Jones")
    @taggables = [@taggable, TaggableModel.new(:name => "John Doe")]
  end

  it "should return tag_list of blank right after new" do
    blank_taggable = TaggableModel.new(:name => "Bob Jones")
    blank_taggable.tag_list.should == ""
  end

  it "should return tag_list of blank right after create" do
    blank_taggable = TaggableModel.create(:name => "Bob Jones")
    blank_taggable.tag_list.should == ""
  end

  it "should have tags of [] right after create" do
    blank_taggable = TaggableModel.create(:name => "Bob Jones")
    blank_taggable.tags.should == []
  end


  it "should be able to remove tags through list alone" do
    @taggable.tag_list = "ruby, rails, css"
    @taggable.save

    @taggable.reload
    @taggable.should have(3).tags
    @taggable.tag_list = "ruby, rails"
    @taggable.save
    @taggable.reload
    @taggable.should have(2).tags
  end

  it "should be able to find by tag" do
    @taggable.tag_list = "ruby, rails, css"
    @taggable.save

    TaggableModel.tagged_with("ruby").first.should == @taggable
  end

  it "should not return read-only records" do
    TaggableModel.create(:name => "Bob", :tag_list => "ruby, rails, css")
    TaggableModel.tagged_with("ruby").first.should_not be_readonly
  end

  it "should find all rows by matching tag" do
    bob = TaggableModel.create(:name => "Bob", :tag_list => "lazy, happier")
    frank = TaggableModel.create(:name => "Frank", :tag_list => "fitter, happier, inefficient")
    steve = TaggableModel.create(:name => 'Steve', :tag_list => "fitter, happier")

    TaggableModel.tagged_with(["happier"]).count.should == 3
  end

  it "should find a single single row by a unique" do
    bob = TaggableModel.create(:name => "Bob", :tag_list => "lazy, happier")
    frank = TaggableModel.create(:name => "Frank", :tag_list => "fitter, happier, inefficient")
    steve = TaggableModel.create(:name => 'Steve', :tag_list => "fitter, happier")
    jane  = TaggableModel.create(:name => 'Jane', :tag_list => "cooler")
    TaggableModel.tagged_with(["cooler"]).count.should == 1
  end

  it "should not find non-existant tag" do
    bob = TaggableModel.create(:name => "Bob", :tag_list => "lazy, happier")
    frank = TaggableModel.create(:name => "Frank", :tag_list => "fitter, happier, inefficient")
    steve = TaggableModel.create(:name => 'Steve', :tag_list => "fitter, happier")
    jane  = TaggableModel.create(:name => 'Jane', :tag_list => "cooler")
    TaggableModel.tagged_with(["evil"]).count.should == 0
  end

  it "should be able to find tagged with all of the matching tags" do
    bob = TaggableModel.create(:name => "Bob", :tag_list => "lazy, happier")
    frank = TaggableModel.create(:name => "Frank", :tag_list => "fitter, happier, inefficient")
    steve = TaggableModel.create(:name => 'Steve', :tag_list => "fitter, happier")

    TaggableModel.tagged_with(["fitter", "happier"]).to_a.sort.should == [steve,frank].sort
  end

  it "should be able to find rows by any tag" do
    bob = TaggableModel.create(:name => "Bob", :tag_list => "lazy, happier")
    frank = TaggableModel.create(:name => "Frank", :tag_list => "fitter, happier, inefficient")
    steve = TaggableModel.create(:name => 'Steve', :tag_list => "fitter, happier")
    jane  = TaggableModel.create(:name => 'Jane', :tag_list => "cooler")

    TaggableModel.tagged_with(["lazy", "cooler"], :any => true).to_a.sort.should == [bob,jane].sort
  end

  it "should return an empty scope for empty tags" do
    TaggableModel.tagged_with('').should == []
    TaggableModel.tagged_with(' ').should == []
    TaggableModel.tagged_with(nil).should == []
    TaggableModel.tagged_with([]).should == []
  end
end  