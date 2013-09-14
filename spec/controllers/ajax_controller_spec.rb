require 'spec_helper'

describe AjaxController do

  describe "GET 'showform'" do
    it "returns http success" do
      get 'showform'
      response.should be_success
    end
  end

  describe "GET 'process'" do
    it "returns http success" do
      get 'process'
      response.should be_success
    end
  end

end
