class ClinicsController < ApplicationController
  before_action :find_clinics, if: :verify_authentication_token

  def show
    return render status: :unauthorized unless @clinics

    render json: @clinics, status: :ok
  end

  private

  def verify_authentication_token
    request.headers["X-Auth-Token"] == ENV["x_auth_token"]
  end

  def find_clinics
    @clinics = Clinic.where(zip_code: zip_code).select(:id, :facility, :phone_number, :city)
  end

  def zip_code
    params[:zip_code]
  end
end
