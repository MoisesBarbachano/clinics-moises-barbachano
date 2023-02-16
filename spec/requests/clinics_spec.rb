require "rails_helper"

RSpec.describe "Clinics", type: :request do
  describe "SHOW /index" do
    let(:clinic_one) do
      Clinic.create(
        facility: "Yuma Regional Outpatient Diagnostic Imaging Ctr.",
        phone_number: "928336-7306",
        city: "Yuma",
        zip_code: 85364
      )
    end

    let(:clinic_two) do
      Clinic.create(
        facility: "Zwanger-Pesiri Radiology",
        phone_number: "928336-7302",
        city: "Harlem",
        zip_code: 81422
      )
    end

    let(:route) { "/clinics/#{zip_code}" }
    let(:zip_code) { 85364 }
    let(:auth_token) { "authorization_token" }

    let(:expected_clinics) do
      [
        {
          id: clinic_one.id,
          facility: clinic_one.facility,
          phone_number: clinic_one.phone_number,
          city: clinic_one.city
        }
      ]
    end

    before do
      clinic_one
      clinic_two
    end

    context "when the request is valid" do
      it "returns HTTP 200" do
        get route, headers: {"X-Auth-Token": auth_token}
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct data" do
        get route, headers: {"X-Auth-Token": auth_token}
        expect(response.body).to eq expected_clinics.to_json
      end
    end

    context "when X-AuthToken is nil" do
      it "returns HTTP 401" do
        get route
        expect(response).to have_http_status(401)
      end
    end

    context "when auth_token is not correct" do
      let(:auth_token) { "not_valid_authorization_token" }

      it "returns HTTP 401" do
        get route, headers: {"X-Auth-Token": auth_token}
        expect(response).to have_http_status(401)
      end
    end
  end
end
