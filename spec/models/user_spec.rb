# encoding: utf-8
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    let(:user) { User.new(params) }
    let(:params) { { 
      name: "user",
      email: "user@example.com",
      password: "password"    
    } } 
    context "when user's data exist" do
      it "is valid user" do
        expect(user).to be_valid
      end
    end

    context "when name does not exist" do
      it "is invalid without a name" do
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end
    end

    context "when the number of characters in the name is long" do
      it "is invalid long name" do
        user.name = "a" * 51
        user.valid?
        expect(user.errors[:name]).to include("は50文字以内で入力してください")
      end
    end

    context "when email does not exist" do
      it "is invalid without a email" do
        user.email = nil
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
    end

    context "when the number of characters in the email is long" do
      it "is invalid long email" do
        user.email = "a" * 244 + "@example.com"
        user.valid?
        expect(user.errors[:email]).to include("は255文字以内で入力してください")
      end
    end

    context "when duplicate email" do
      it "is invalid duplicate email" do
        user.save
        user2 = user.dup
        user2.valid?
        expect(user2.errors[:email]).to include("はすでに存在します")
      end
    end

    context "when uppercase email" do
      it "is saved with a lowercase email" do
        user.email = "User@ExAMPle.CoM"
        user.save
        expect(user.email).to eq "user@example.com"
      end
    end

    context "when password does not exist" do
      it "is invalid without a password" do
        user.password = " " * 6
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
    end

    context "when the number of characters in the password is short" do
      it "is invalid short password" do
        user.password = "a" * 5
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end
end
