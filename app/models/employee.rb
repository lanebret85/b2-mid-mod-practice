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

  
  def shared_ticket_employees(ticket)
    other_employees = []
    employees = Employee.joins(:tickets).where(tickets: ticket)
    employees.each do |employee|
      other_employees << employee
    end
    other_employees.delete(self)
    other_employees
  end

  def unique_employees
    employees = []
    self.tickets.each do |ticket|
      shared_ticket_employees(ticket).each do |employee|
        employees << employee
      end
    end
    employees.uniq
  end
end