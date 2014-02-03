require 'spec_helper'


describe ApplicationHelper do
  describe "full_title" do
    it "composes a full title for a page" do
      helper.full_title('Title').should == "Romiboweb | Title"
    end
  end
end