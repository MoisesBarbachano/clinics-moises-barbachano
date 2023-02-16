class Clinic < ApplicationRecord
  validates :facility, presence: true
  validates :zip_code, presence: true
  validates :zip_code, numericality: {only_integer: true}
end
