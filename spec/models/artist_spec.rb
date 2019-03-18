require 'rails_helper'
RSpec.describe Artist, type: :model do
  let(:artist) { create(:artist) }

  it "is valid" do
    expect(artist).to be_valid
  end
end
