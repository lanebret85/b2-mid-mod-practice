class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  validates :name, presence: true
  validates :level, presence: true

  def sort_tickets_by_age
    tickets.order(age: :desc)
  end

  def oldest_ticket
    sort_tickets_by_age.first
  end
end