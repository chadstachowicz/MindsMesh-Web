require 'spec_helper'

describe Topic do
  it "slugfies" do
  	t = Fabricate.build(:topic)
  	-> {
  	  t.valid?
  	}.should change(t, :slug)
  end

  pending "remove duplicated logic from topics#join"

  it "user_join" do
  	u = Fabricate(:user)
  	t = Fabricate(:topic)

    ->{
      ->{
  		t.user_join(u)
      }.should change(u.topic_users, :count).by(1)
    }.should change(t.topic_users, :count).by(1)
  end
end
