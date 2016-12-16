class Charge < ApplicationRecord

  enum on_action: [:unset, :casting_creation, :casting_dates_change, :casting_expired_confirmations]

  after_initialize :set_default_action, if: :new_record?

  def set_default_action
    self.on_action ||= :unset
  end

  # Associations
  belongs_to :profileable, polymorphic: true
end
