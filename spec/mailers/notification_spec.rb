require "spec_helper"

describe Notification do
  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Orange", value: "#d45300")
  end

  let(:user){FactoryGirl.create :user}
  let(:feedback) { FactoryGirl.create(:feedback)}

  describe "user_feedback" do
    let(:mail) { Notification.user_feedback(user, feedback) }

    it "renders the headers" do
      mail.subject.should eq("User Feedback on RomiboWeb")
      mail.to.should eq(["aubreyshick@origamirobotics.com",
                         "jared@origamirobotics.com",
                         "john.lee@sv.cmu.edu",
                         "abhi.trivedi@sv.cmu.edu",
                         "danny.brown@sv.cmu.edu"])
      mail.from.should eq(["aubreyshick@origamirobotics.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
