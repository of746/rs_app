class Room < ApplicationRecord
  has_one_attached :facility_image
  belongs_to :user
  has_many :reservations, dependent: :destroy
  validates :user_id, presence: true
  validates :facility_name, :facility_Introduction, :fee, :address, presence: true
  validates :fee, numericality: { greater_than_or_equal_to: 1 }
end
