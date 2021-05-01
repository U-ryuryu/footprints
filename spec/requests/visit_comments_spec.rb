require 'rails_helper'

RSpec.describe "VisitComments", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/visit_comments/create"
      expect(response).to have_http_status(:success)
    end
  end

end
