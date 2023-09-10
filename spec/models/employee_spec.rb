require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it {should have_many(:tickets).through(:employee_tickets) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :level }
  end

  before :each do
    @it = Department.create!(name: "IT", floor: "Basement")

    @bobby_flay = @it.employees.create!(name: "Bobby Flay", level: 3)
    
    @broken_printer = Ticket.create!(subject: "Printers Broken", age: 5)
    @dropped_database = Ticket.create!(subject: "Database Dropped", age: 1)
    @coffee_filters = Ticket.create!(subject: "Out of Coffee Filters", age: 3)
    
    EmployeeTicket.create!(employee_id: @bobby_flay.id, ticket_id: @broken_printer.id)
    EmployeeTicket.create!(employee_id: @bobby_flay.id, ticket_id: @dropped_database.id)
    EmployeeTicket.create!(employee_id: @bobby_flay.id, ticket_id: @coffee_filters.id)
  end

  describe "#sort_by_age" do
    it "can sort an employees tickets oldest to newest" do
      query = @bobby_flay.sort_tickets_by_age

      expect(query).to eq([@broken_printer, @coffee_filters, @dropped_database])
    end
  end

  describe "#oldest_ticket" do
    it "can return the oldest ticket assigned to an employee" do
      query = @bobby_flay.oldest_ticket

      expect(query).to eq(@broken_printer)
    end
  end
end