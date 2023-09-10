class Employee < ApplicationRecord
  belongs_to :department

  validates :name, presence: true
  validates :level, presence: true
end