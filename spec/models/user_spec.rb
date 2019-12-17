require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    
    subject { described_class.new(first_name: "John", last_name: "Doe", email: "john@gmail.com", password: "abc", password_confirmation: "abc") }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end

    it "is not valid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("First name can't be blank")
    end

    it "is not valid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Last name can't be blank")
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end

    it "is not valid if password length is less than 3" do
      subject.password = " "
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end

    it "is not valid without a password confirmation" do
      subject.password_confirmation = ""
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password confirmation is too short (minimum is 3 characters)")
    end
    
    it "is not valid if password and password confirmation do not match" do
      subject.password_confirmation = '456'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "is not valid if user with same email exists - case-insensitive" do
      validUser = User.create(first_name: "Jane", last_name: "Smith", email: "JOHN@gmail.com", password: "abc", password_confirmation: "abc")
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Email : Umm, did you mean to log in??")
    end
  end

  describe '.authenticate_with_credentials' do

    before(:all) do
      @user = described_class.create(first_name: "John", last_name: "Doe", email: "john@gmail.com", password: "abc", password_confirmation: "abc")
    end
    
    it "should return nil if email does not exist" do
      loggedin = User.authenticate_with_credentials('johnny@gmail.com', 'abc')
      expect(loggedin).to be_nil
    end
    
    it "should return nil if password does not match" do
      loggedin = User.authenticate_with_credentials('john@gmail.com', 'abcd')
      expect(loggedin).to be_nil
    end
    
    it "should return @user if email and password match user" do
      loggedin = User.authenticate_with_credentials('john@gmail.com', 'abc')
      expect(loggedin).to eq(@user)
    end

    it "should return @user if email has spaces before and/or after" do
      loggedin = User.authenticate_with_credentials('    john@gmail.com ', 'abc')
      expect(loggedin).to eq(@user)
    end

    it "should return @user if email case is does not match db record" do
      loggedin = User.authenticate_with_credentials('    JOhn@gmail.com ', 'abc')
      expect(loggedin).to eq(@user)
    end

    after(:all) do
      @user.destroy
    end
    
  end
end