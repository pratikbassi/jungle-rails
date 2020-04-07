require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Users' do

    it "validates correctly" do
      new_user = User.new({name: "Pratik Bassi", password:"password", password_confirmation:"password", email:"pratikbassi@yahoo.com"})
      new_user.valid?
      expect(!new_user.errors.full_messages)
    end

    it "does not allow users without names" do 
      new_user = User.new({name: nil, password:"password", password_confirmation:"password", email:"joe@yahoo.com"})
      new_user.valid?
      expect(new_user.errors.full_messages).to include("Name can't be blank")
    end

    it "does not allow users without passwords" do 
      new_user = User.new({name: "Pratik", password:nil, password_confirmation:nil, email:"joe@yahoo.com"})
      new_user.valid?
      expect(new_user.errors.full_messages).to include("Password can't be blank")
    end

    it "does not allow passwords to not match" do 
      new_user = User.new({name: "Pratik", password:"Hellooo", password_confirmation:"Woooorld", email:"joe@yahoo.com"})
      new_user.valid?
      expect(new_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "does not allow passwords less than 6 chars in length" do 
      new_user = User.new({name: "Pratik", password:"Hello", password_confirmation:"Hello", email:"joe@yahoo.com"})
      new_user.valid?
      expect(new_user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "does not allow two users with the same email address" do 
      new_user = User.new({name: "Pratik Bassi", password:"password", password_confirmation:"password", email:"pratikbassi@yahoo.com"})
      new_user.save
      newer_user = User.new({name: "Issab Kitarp", password:"password", password_confirmation:"password", email:"pratikbassi@yahoo.com"})
      newer_user.valid?
      expect(newer_user.errors.full_messages).to include("Email has already been taken")
    end

  end

  describe '.authenticate_with_credentials' do

    it "Allows a correct login" do
      login_user = User.authenticate_with_credentials("pratikbassi@yahoo.com", "password")
      expect(login_user)
    end

    it "Stops a wrong password" do
      login_user = User.authenticate_with_credentials("pratikbassi@yahoo.com", "Hello")
      expect(!login_user)
    end

    it "Allows a login with case problems" do
      login_user = User.authenticate_with_credentials("pratikBassi@yahoo.com", "password")
      expect(login_user)
    end

    it "Allows a login with space problems" do
      login_user = User.authenticate_with_credentials("  pratikBassi@yahoo.com  ", "password")
      expect(login_user)
    end
  end
end
