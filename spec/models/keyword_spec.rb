require 'rails_helper'
RSpec.describe Keyword, type: :model do
  let(:valid_keyword) { create(:keyword) }
  let(:invalid_keyword) { create(:keyword, keyword: "") }

  describe "(validation)" do
    it "is valid with a keyword" do
      expect(valid_keyword).to be_valid
    end

    it "is invalid without a keyword" do
      expect(invalid_keyword).not_to be_valid
    end

    context "dupulicated keyword" do
      let!(:valid_keyword1) { create(:keyword) }
      let!(:valid_keyword2) { create(:keyword) }

      it "is invalid with same name" do
        expect(valid_keyword2).not_to be_valid
      end
    end
  end
end
