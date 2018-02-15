require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:topic) { create(:topic) }
  let(:bookmark) { create(:bookmark) }

  it { is_expected.to belong_to(:topic) }

  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:topic) }

  describe "attributes" do
    it "has url and topic attributes" do
      expect(bookmark).to have_attributes(url: bookmark.url, topic: bookmark.topic)
    end
  end
end
