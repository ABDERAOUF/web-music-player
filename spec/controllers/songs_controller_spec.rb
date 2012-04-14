require 'spec_helper'

describe SongsController do

  describe "GET 'index'" do
    it "returns all songs" do

    end
  end

  describe "POST 'create'" do

    before(:each) do
      @attr = { :name => "Thriller" }
    end

    it "should create a song" do
      lambda do
        post :create, :song => @attr
      end.should change(Song, :count).by(1)
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      put 'update'
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy'
      response.should be_success
    end
  end

end
