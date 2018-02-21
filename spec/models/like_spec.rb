require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user)     { create(:user) }
  let(:topic)    { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  it { is_expected.to belong_to(:bookmark) }
  it { is_expected.to belong_to(:user) }
end
