require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    # validation tests/examples here
    it "is valid when password and password confirmation are not missing" do

      subject = User.new(
        first_name: "trigun", 
        last_name: "joshi", 
        email: "test@test.com", 
        password: "ABCDE1234", 
        password_confirmation: "ABCDE1234"
        )
      
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty
    end

    it "is invalid when first name is missing" do

      subject = User.new(
        first_name: nil, 
        last_name: "joshi", 
        email: "test@test.com", 
        password: "ABCDE1234", 
        password_confirmation: "ABCDE1234"
        )
      
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("First name can't be blank")
    end

    it "is invalid when last name is missing" do

      subject = User.new(
        first_name: "trigun", 
        last_name: nil, 
        email: "test@test.com", 
        password: "ABCDE1234", 
        password_confirmation: "ABCDE1234"
        )
      
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Last name can't be blank")
    end

    it "is invalid when email is missing" do

      subject = User.new(
        first_name: "trigun", 
        last_name: "joshi", 
        email: nil, 
        password: "ABCDE1234", 
        password_confirmation: "ABCDE1234"
        )
      
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Email can't be blank")
    end

    it "is invalid when password is missing" do

      subject = User.new(
        first_name: nil, 
        last_name: "joshi", 
        email: "test@test.com", 
        password: nil, 
        password_confirmation: "ABCDE1234"
        )
      
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Password can't be blank")
    end

    it "is invalid when password and password confirmation is not matching" do

      subject = User.new(
        first_name: 'Trigun', 
        last_name: "joshi", 
        email: "test@test.com", 
        password: "ABCDE1234", 
        password_confirmation: "abcde1234"
        )
      
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "is invalid when password is less than 8 characters" do

      subject = User.new(
        first_name: 'Trigun', 
        last_name: "joshi", 
        email: "test@test.com", 
        password: "ABCD", 
        password_confirmation: "abcd"
        )
      
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'return a user if email is already registered' do
      user = User.create({
        first_name: 'Trigun', 
        last_name: "joshi", 
        email: "test@test.com", 
        password: "ABCD1234", 
        password_confirmation: "ABCD1234"
      })
      expect(User.authenticate_with_credentials("test@test.com", "ABCD1234")).to eql(user)
    end
  
     it 'return a user is not registered' do
      user = User.create({
        first_name: 'Trigun', 
        last_name: "joshi", 
        email: "test234@test.com", 
        password: "ABCD1234", 
        password_confirmation: "ABCD1234"
      })
      expect(User.authenticate_with_credentials("test@test.com", "ABCD1234")).to eql(nil)
    end
    it 'return a registered password is not matching' do
      user = User.create({
        first_name: 'Trigun', 
        last_name: "joshi", 
        email: "test234@test.com", 
        password: "ABCD1234", 
        password_confirmation: "ABCDasd1234"
      })
      expect(User.authenticate_with_credentials("test@test.com", "ABCD1234")).to eql(nil)
    end
    it 'authenticates when email is correct but contains whitespace around it' do
      user = User.create({
        first_name: 'Trigun', 
        last_name: "joshi", 
        email: "test@test.com", 
        password: "ABCD1234", 
        password_confirmation: "ABCD1234"
      })
      expect(User.authenticate_with_credentials("   test@test.com", "ABCD1234")).to eq(user)
    end
    it "authenticates when email is correct but in the wrong case" do
        user = User.create({
        first_name: 'Trigun', 
        last_name: "joshi", 
        email: "test@test.com", 
        password: "ABCD1234", 
        password_confirmation: "ABCD1234"
      })
      expect(User.authenticate_with_credentials("TeST@test.com", user.password)).to eq(user)
    end
  end


end
