require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do

  let(:user) { create(:user) }
  let (:example_topic) { create(:topic) }
  let (:example_bookmark) { create(:bookmark, topic: example_topic) }

  context "signed in user" do
    before do
      sign_in user
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: {  topic_id: example_topic.id, id: example_bookmark.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { topic_id: example_topic.id, id: example_bookmark.id }
        expect(response).to render_template :show
      end

      it "assigns example_bookmark to @example_bookmark" do
        get :show, params: { topic_id: example_topic.id, id: example_bookmark.id }
        expect(assigns(:bookmark)).to eq(example_bookmark)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, params: { topic_id: example_topic.id }
        expect(response).to have_http_status(:success)
      end

      it "initializes @bookmark" do
        get :new, params: { topic_id: example_topic.id }
        expect(assigns(:bookmark)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of bookmarks by 1" do
        expect{ post :create, xhr: true, params: { topic: example_topic, bookmark: { url: "http://testing1234.edu" } } }.to change(Bookmark,:count).by(1)
      end
    end
  end
end
