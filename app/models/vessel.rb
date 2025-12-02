class Vessel < ApplicationRecord
  belongs_to :shipping_line

  validates :name, presence: true, uniqueness: { scope: :shipping_line_id }
  validates :shipping_line_id, presence: true
end
