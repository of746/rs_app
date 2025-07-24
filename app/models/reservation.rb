class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :checkin_date, :checkout_date, :number_of_people, presence: true
  validate :check_in_must_be_today_or_later
  validate :check_out_after_check_in
  validates :number_of_people, numericality: { greater_than_or_equal_to: 1 }

  def stay_days
    (checkout_date - checkin_date).to_i
  end

  def total_price
    stay_days * number_of_people * room.fee
  end

  private

  def check_in_must_be_today_or_later
    if checkin_date.present? && checkin_date < Date.today
      errors.add(:checkin_date, "は今日以降の日付にしてください")
    end
  end

  def check_out_after_check_in
    if checkin_date.present? && checkout_date.present? && checkout_date <= checkin_date
      errors.add(:checkout_date, "はチェックインより後の日付にしてください")
    end
  end
end
