
# MindsMesh (c) 2013

require "spec_helper"

describe MyMail do
  describe "confirmation" do

    let(:mail) do
      @token = Digest::MD5.hexdigest(Time.now.to_s)
      @eur = Fabricate.build(:entity_user_request, confirmation_token: @token)
      MyMail.confirmation(@eur)
    end

    it "renders the headers" do
      mail.subject.should eq("Welcome to MindsMesh!")
      mail.to.should eq([@eur.email])
      mail.from.should eq(["noreply@mindsmesh.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(@eur.confirmation_token)
      mail.body.encoded.should match('test.host')
    end
  end

end
