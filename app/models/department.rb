class Department < ApplicationRecord
  has_many :employees

  validates :name, presence: true
  validates :floor, presence: true
end