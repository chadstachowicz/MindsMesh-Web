require 'spec_helper'

describe Reply do
  describe "associations" do
    describe "understands belongs_to" do
      {user: User, post: Post}.each do |assoc, clazz|
        it assoc do
          reply = Fabricate(:reply)
          reply.should respond_to(assoc)
          reply.send(assoc).should be_a(clazz)
        end
      end
    end
    describe "understands has_many" do
      before do
        @record_class = :reply
      end
      {likes: Like}.each do |assoc, clazz|
        it assoc do
          record = Fabricate.build(@record_class) { send(assoc, count: 3) }
          record.should respond_to(assoc)
          record.send(assoc).should be_a Array
          record.send(assoc).sample.should be_a clazz
        end
      end
    end
  end

  describe "simple field validations" do
    it "requires text" do
      reply = Fabricate.build(:reply, text: nil)
      reply.should_not be_valid
      reply.errors[:text].should_not be_empty
    end
    it "requires text to have at least 10 chars" do
      reply = Fabricate.build(:reply, text: '')
      reply.should_not be_valid
      reply.errors[:text].should_not be_empty
      reply.text = '1'
      reply.valid?
      reply.errors[:text].should be_empty
    end
  end
end
