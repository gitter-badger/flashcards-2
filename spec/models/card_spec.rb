require 'rails_helper'

RSpec.describe Card, type: :model do
  it "is valide with original_text, translated_text" do
    puts build(:card).original_text
    puts build(:card).translated_text
    expect(build(:card)).to be_valid
  end

  describe "check validations" do
    it "is invalide without original_text" do
      card = build(:card, original_text: nil)
      expect(card.valid?).to eq(false)
    end

    it "is invalide without translated_text" do
      card = build(:card, translated_text: nil)
      expect(card.valid?).to eq(false)
    end

    it "is invalide with blank fields" do
      card = Card.new()
      expect(card.valid?).to eq(false)
    end

    it "has valide review_date" do
      card = build(:card)
      expect(card.review_date).to eq(Date.today + 3.days)
    end

    it "has different original_text and translated_text" do
      card = Card.new(original_text:   "Door", 
                      translated_text: "Door")
      expect(card.valid?).to eq(false)
    end

    it "has different original_text and translated_text(Russian)" do
      card = Card.new(original_text:   "Дверь", 
                      translated_text: "Дверь")
      expect(card.valid?).to eq(false)
    end
  end

  describe "check review date" do
    before :each do
      @card = build(:card)
    end

    it "is NOT include in pending list, with incorrect date" do
      #card.review_date == (Date.today + 3.days), after_initialize if new_record
      @card.save
      expect(Card.pending).not_to include(@card)
    end

    it "is include in pending list, with correct date" do
      #card.review_date == (Date.today + 3.days), after_initialize if new_record
      @card.review_date = Date.today - 20.days
      @card.save
      expect(Card.pending).to include(@card)
    end
  end

  describe "Bounds values for review_date" do
    before :each do
      @card = build(:card)
    end

    it "is include in pending list, if review_date equals #{Date.today - 4.days}" do
      #card.review_date == (Date.today + 3.days), after_initialize if new_record
      @card.review_date = Date.today - 4.days
      @card.save
      expect(Card.pending).to include(@card)
    end

    it "is include in pending list, if review_date equals #{Date.today - 3.days}" do
      #card.review_date == (Date.today + 3.days), after_initialize if new_record
      @card.review_date = Date.today - 3.days
      @card.save
      expect(Card.pending).to include(@card)
    end

    it "is NOT include in pending list, if review_date equals #{Date.today - 2.days}" do
      #card.review_date == (Date.today + 3.days), after_initialize if new_record
      @card.review_date = Date.today - 2.days
      @card.save
      expect(Card.pending).not_to include(@card)
    end
  end
end