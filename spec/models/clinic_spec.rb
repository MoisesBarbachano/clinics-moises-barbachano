require "rails_helper"

RSpec.describe Clinic, type: :model do
  let(:facility) { "Zwanger-Pesiri Radiology Group, LLP" }
  let(:phone_number) { "631444-5544" }
  let(:city) { "Lindenhurst" }
  let(:zip_code) { 11757 }

  subject(:clinic) do
    Clinic.new(
      facility: facility,
      phone_number: phone_number,
      city: city,
      zip_code: zip_code
    )
  end

  before { subject.save }

  it { is_expected.to validate_presence_of(:facility) }
  it { is_expected.to validate_presence_of(:zip_code) }
  it { is_expected.to validate_numericality_of(:zip_code) }

  context "when clinic is valid" do
    it { expect(clinic).to be_valid }
  end

  context "when facility is nil" do
    let(:facility) { nil }

    it { expect(clinic).to_not be_valid }
  end

  context "when zip_code is nil" do
    let(:zip_code) { nil }

    it { expect(clinic).to_not be_valid }
  end

  context "when zip_code is NOT number" do
    let(:zip_code) { "this_is_a_string" }

    it { expect(clinic).to_not be_valid }
  end
end
