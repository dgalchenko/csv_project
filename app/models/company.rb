class Company < ApplicationRecord
  validates :registry_number, presence: true, length: { maximum: 13 }
  validates :name, :city, presence: true, length: { maximum: 255 }
end
