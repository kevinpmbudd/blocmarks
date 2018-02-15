require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

  it { is_expected.to belong_to(:user) }

  it { should have_many(:bookmarks) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:user) }

  describe "attributes" do
    it "has title and user attributes" do
      expect(topic).to have_attributes(title: topic.title, user: topic.user)
    end
  end
end
