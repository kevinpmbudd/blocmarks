require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }
  it { should have_many(:likes) }

  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }


  describe "attributes" do
    it "has url, user and topic attributes" do
      expect(bookmark).to have_attributes(url: bookmark.url, topic: bookmark.topic, user: bookmark.user)
    end
  end
end
