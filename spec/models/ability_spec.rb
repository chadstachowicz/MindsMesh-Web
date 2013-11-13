
# MindsMesh, Inc. (c) 2012-2013

require 'spec_helper'

describe Ability do
  describe 'student' do
    subject do 
      @user = create :user, :role => 'student'
      @user.administratable = @me
      @user.save
      @user_belonging_to_the_same_org = create :user, :role => 'student'
      @user_belonging_to_the_same_org.administratable = @me
      @user_belonging_to_the_same_org.save
      @some_other_user = create :user, :role => 'student'
      @some_other_user.administratable = @other_student
      @some_other_user.save
      Ability.new @user
    end

    describe 'access to entities' do
      before do
        @me = create :student
        @other_student = create :student
        @client = create :client
        @agreement = create :agreement, :student => @me
        @product = create :product
        @product.agreements << @agreement
        @product.save
        @others_agreement = create :agreement
        @others_product = create :product
        @others_product.agreements << @others_agreement
        @others_product.save
      end

      it { subject.must_be_able_to(:read, @user)} 
      it { subject.must_be_able_to(:read, @user_belonging_to_the_same_org)}
      it { subject.must_be_able_to(:update, @user)}
      it { subject.must_be_able_to(:update, @user_belonging_to_the_same_org)}
      it { subject.must_be_able_to(:create, User.new( administratable_type: @me.class.to_s, administratable_id: @me.id))}
      it { subject.must_not_be_able_to(:read, @some_other_user)}
      it { subject.must_not_be_able_to(:update, @some_other_user)}
      it { subject.must_not_be_able_to(:create, User.new( administratable_type: @me.class.to_s, administratable_id: @other_student.id))}

      it { subject.must_not_be_able_to(:read, @other_student)}
      it { subject.must_not_be_able_to(:update, @other_student)}
      it { subject.must_be_able_to(:read, @me)}
      it { subject.must_be_able_to(:update, @me)}

      it { subject.must_be_able_to(:read, @agreement)}
      it { subject.must_be_able_to(:update, @agreement)}
      it { subject.must_not_be_able_to(:create, @others_agreement)}
      # it { subject.must_not_be_able_to(:destroy, @others_agreement)}
      it { subject.must_not_be_able_to(:update, @others_agreement)}
      it { subject.must_not_be_able_to(:read, @others_agreement)}

      it { subject.must_be_able_to(:search, @product)}
      it { subject.must_be_able_to(:create, @product)}
      it { subject.must_be_able_to(:read, @product)}
      it { subject.must_be_able_to(:update, @product)}
      it { subject.must_be_able_to(:destroy, @product)}
      it { subject.must_be_able_to(:upload_form, Product)}
      it { subject.must_be_able_to(:upload, Product)}

      it { subject.must_not_be_able_to(:create, @others_product)}
      it { subject.must_not_be_able_to(:read, @others_product)}
      it { subject.must_not_be_able_to(:update, @others_product)}
      it { subject.must_not_be_able_to(:destroy, @others_product)}
    end
  end

#This is an administrator for the buyer rather than a buyer itself
  describe 'buyer' do
    subject do
      @user = create :user, :role => 'buyer'
      @user.administratable = @me
      @user.save
      @user_belonging_to_the_same_org = create :user, :role => 'buyer'
      @user_belonging_to_the_same_org.administratable = @me
      @user_belonging_to_the_same_org.save
      @some_other_user = create :user, :role => 'buyer'
      @some_other_user.administratable = @other_client
      @some_other_user.save
      Ability.new @user
    end

    describe 'access to entities' do
      before do
        @product = create :product
        @student = create :student
        @me = create :client
        @other_client = create :client
        @agreement = create :agreement, :client => @me
        @others_agreement = create :agreement
      end

      it { subject.must_be_able_to(:read, @user)} 
      it { subject.must_be_able_to(:read, @user_belonging_to_the_same_org)}
      it { subject.must_be_able_to(:update, @user)}
      it { subject.must_be_able_to(:update, @user_belonging_to_the_same_org)}
      it { subject.must_be_able_to(:create, User.new( administratable_type: @me.class.to_s, administratable_id: @me.id))}
      it { subject.must_not_be_able_to(:read, @some_other_user)}
      it { subject.must_not_be_able_to(:update, @some_other_user)}
      it { subject.must_not_be_able_to(:create, User.new( administratable_type: @me.class.to_s, administratable_id: @other_client.id))}

      it { subject.must_be_able_to(:search, @product)}
      it { subject.must_be_able_to(:read, @product)}
      it { subject.must_be_able_to(:read, @student)}
      it { subject.must_not_be_able_to(:read, @other_client)}
      it { subject.must_not_be_able_to(:update, @other_client)}
      it { subject.must_be_able_to(:read, @me)}
      it { subject.must_be_able_to(:update, @me)}
      it { subject.must_be_able_to(:read, @agreement)}
      it { subject.must_be_able_to(:create, @agreement)}
      it { subject.must_be_able_to(:update, @agreement)}
      # it { subject.must_be_able_to(:destroy, @agreement)}
      it { subject.must_not_be_able_to(:create, @others_agreement)}
      # it { subject.must_not_be_able_to(:destroy, @others_agreement)}
      it { subject.must_not_be_able_to(:update, @others_agreement)}
      it { subject.must_not_be_able_to(:read, @others_agreement)}
      it { subject.must_be_able_to(:upload_form, Product)}
      it { subject.must_be_able_to(:upload, Product)}
    end
  end

  describe 'admin' do
    subject do 
      u = User.new
      u.role = 'admin'
      Ability.new u
    end

    it { subject.must_be_able_to(:manage, :all)}

  end
end
