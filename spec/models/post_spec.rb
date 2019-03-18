require 'rails_helper'
RSpec.describe Post, type: :model do
  let(:valid_post) { create(:post) }
  let(:invalid_post1) { create(:post, question: "") }
  let(:invalid_post2) { create(:post, answer1: "") }
  let(:invalid_post3) { create(:post, answer2: "") }
  let(:invalid_post4) { create(:post, answer3: "") }
  let(:invalid_post5) { create(:post, answer4: "") }

  describe "(validation)" do
    it "is invalid without a question" do
      expect(invalid_post1).not_to be_valid
    end

    it "is invalid without a answer1" do
      expect(invalid_post2).not_to be_valid
    end

    it "is invalid without a answer2" do
      expect(invalid_post3).not_to be_valid
    end

    it "is invalid without a answer3" do
      expect(invalid_post4).not_to be_valid
    end

    it "is invalid without a answer4" do
      expect(invalid_post5).not_to be_valid
    end
  end
end
