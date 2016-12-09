class Coupon < ApplicationRecord
  # Status
  enum status: [:active, :used]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
  	self.status ||= :active
  end

  # Validations
  validates :amount, numericality: { greater_than: 0, less_than_or_equal_to: 999 }

  before_save :generate_code

  def generate_code
    raw_string =  SecureRandom.random_number(2**80).to_s(20).reverse
    long_code = raw_string.tr('0123456789abcdefghij', '234679QWERTYUPADFGHX')
    short_code = long_code[0..3] << '-' << long_code[4..7] << '-' << long_code[8..11]

    self.code = short_code
  end

  # Scopes
  scope :actives, -> { where(status: "active") }

  def use!
  	used!
  	save
  end
end
