require 'rails_helper'
RSpec.describe Answer, type: :model do
  let!(:valid_answer) { create(:answer, user_id: 1) }
  let!(:invalid_answer) { create(:answer, name: "") }
  let!(:post) { create(:post, user_id: 1) }
  let!(:keyword) { create(:keyword, user_id: 1) }

  describe "#search_post" do
    context "when it has a post" do
      it "returns correct data" do
          expect(Answer.search_post(1, 1)).to eq post
      end
    end

    context "when it does not have any posts" do
      it "returns nil" do
          expect(Answer.search_post(1, 2)).to eq nil
      end
    end
  end

  describe "#update_correct_num" do
      it "correct num plus 1" do
          Answer.update_correct_num(valid_answer.name, valid_answer)
          expect(valid_answer.correct).to eq 1
      end
  end

  describe "#find_answer_by_name" do
      it "returns correct answer" do
          expect(Answer.find_answer_by_name(valid_answer.name)).to eq valid_answer
      end
  end

  describe "(validation)" do
    it "is valid with a name" do
      expect(valid_answer).to be_valid
    end

    it "is invalid without a name" do
      expect(invalid_answer).not_to be_valid
    end

    context "dupulicated keyword" do
      let!(:valid_answer1) { create(:keyword) }
      let!(:valid_answer2) { create(:keyword) }

      it "is invalid with same name" do
        expect(valid_answer2).not_to be_valid
      end
    end
  end
end
