require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  let(:user)     { create(:user) }
  let(:topic)    { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }
  let(:like)     { create(:like, user: user, bookmark: bookmark) }

  describe "GET #index" do
    it "returns http success" do
      get :index, params: { topic_id: topic.id, bookmark_id: bookmark.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns Like.all to likes" do
      get :index, params: { topic_id: topic.id, bookmark_id: bookmark.id }
      expect(assigns(:likes)).to eq([like])
    end
  end

  context "signed in user" do
    before do
      sign_in user
    end

    describe "POST create" do
      it "redirects to the bookmark show view" do
        post :create, params: { topic_id: topic.id, bookmark_id: bookmark.id }
        expect(response).to redirect_to([topic, bookmark])
      end

      it "creates a like for the current user and specified bookmark" do
        expect(user.likes.find_by_bookmark_id(bookmark.id)).to be_nil
        post :create, params: { topic_id: topic.id, bookmark_id: bookmark.id }
        expect(user.likes.find_by_bookmark_id(bookmark.id)).not_to be_nil
      end
    end

    describe "DELETE destroy" do
      it "redirects to the bookmark show view" do
        like = user.likes.where(bookmark: bookmark).create
        delete :destroy, params: { topic_id: topic.id, bookmark_id: bookmark.id, id: like.id }
        expect(response).to redirect_to([topic, bookmark])
      end

      it "destroys the like for the current user and bookmark" do
        like = user.likes.where(bookmark: bookmark).create
        expect(user.likes.find_by_bookmark_id(bookmark.id)).not_to be_nil
        delete :destroy, params: { topic_id: topic.id, bookmark_id: bookmark.id, id: like.id }
        expect(user.likes.find_by_bookmark_id(bookmark.id)).to be_nil
      end
    end
  end

end
