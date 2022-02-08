require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "is valid with valid attributes" do
      category = Category.new(name: "Trigun")
       subject = Product.new(
         name: 'Trigun',
         category: category,
         price_cents: 779,
         quantity: 20,
       )
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty
    end

    it "is invalid when name is missing" do
      category = Category.new(name: "Trigun")
       subject = Product.new(
         name: nil,
         category: category,
         price_cents: 777,
         quantity: 20,
       )
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Name can't be blank")
    end  

     it "is invalid when category is missing" do
      
       subject = Product.new(
         name: 'Trigun',
         category: nil,
         price_cents: 777,
         quantity: 20,
       )
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Category can't be blank")
    end
    it "is invalid when category is missing" do
      category = Category.new(name: "Trigun")
       subject = Product.new(
         name: 'Trigun',
         category: category,
         price_cents: nil,
         quantity: 20,
       )
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Price can't be blank")
    end
    it "is invalid when quantity is missing" do
      category = Category.new(name: "Trigun")
       subject = Product.new(
         name: 'Trigun',
         category: category,
         price_cents: 977,
         quantity: nil,
       )
    expect(subject).to be_invalid
    expect(subject.errors.full_messages).to include("Quantity can't be blank")
    end
  end
end