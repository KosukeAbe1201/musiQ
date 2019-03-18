require 'rails_helper'
RSpec.describe User, type: :model do
  let(:valid_user) { create(:user) }
  let(:invalid_user1) { create(:user, name: "") }
  let(:invalid_user2) { create(:user, password: "") }
  let(:invalid_user3) { create(:user, password: "1234567") }

  describe "(validation)" do
    it "is valid with a name and password" do
      expect(valid_user).to be_valid
    end

    it "is invalid without a name" do
      expect(invalid_user1).not_to be_valid
    end

    it "is invalid without a password" do
      expect(invalid_user2).not_to be_valid
    end

    it "is invalid with too short password" do
      expect(invalid_user3).not_to be_valid
    end

    context "dupulicated user" do
      let!(:valid_user1) { create(:user) }
      let!(:valid_user2) { create(:user) }

      it "is invalid with same name" do
        expect(valid_user2).not_to be_valid
      end
    end
  end
end
