require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  let(:user) { create(:user) }
  let (:example_topic) { create(:topic) }

  context "signed in user" do
    before do
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns Topic.all to topics" do
        get :index
        expect(assigns(:topics)).to eq([example_topic])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: example_topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: example_topic.id }
        expect(response).to render_template :show
      end

      it "assigns example topic to @topic" do
        get :show, params: { id: example_topic.id }
        expect(assigns(:topic)).to eq(example_topic)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "initializes @topic" do
        get :new
        expect(assigns(:topic)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of topics by 1" do
        expect{ post :create, xhr: true, params: { topic: { title: "new topic" } } }.to change(Topic,:count).by(1)
      end
    end

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, xhr: true, params: { id: example_topic.id }
        count = Topic.count
        expect(count).to eq 0
      end
    end
  end
end
