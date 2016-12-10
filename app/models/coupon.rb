class Coupon < ApplicationRecord
  # Status
  enum status: [:active, :given, :used]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
  	self.status ||= :active
  end

  # Validations
  validates :amount, numericality: { greater_than: 0, less_than_or_equal_to: 999 }

  before_save :generate_code, if: :new_record?

  def generate_code
    raw_string =  SecureRandom.random_number(2**80).to_s(20).reverse
    long_code = raw_string.tr('0123456789abcdefghij', '234679QWERTYUPADFGHX')
    code = long_code[0..11]

    self.code = code
  end

  # Scopes
  scope :actives, -> { where(status: "active") }
  scope :givens, -> { where(status: "given") }
  scope :useds, -> { where(status: "used") }

  def use!
  	used!
  	save
  end

  def give!
    given!
    save
  end

  def formated_code
    return code[0..3] << '-' << code[4..7] << '-' << code[8..11]
  end
end
