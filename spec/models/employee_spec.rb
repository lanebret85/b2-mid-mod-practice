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

    @christina_aguilera = @it.employees.create!(name: "Christina Aguilera", level: 2)
    @bobby_flay = @it.employees.create!(name: "Bobby Flay", level: 3)
    @jimmy_fallon = @it.employees.create!(name: "Jimmy Fallon", level: 4)
    
    @broken_printer = Ticket.create!(subject: "Printers Broken", age: 5)
    @dropped_database = Ticket.create!(subject: "Database Dropped", age: 1)
    @coffee_filters = Ticket.create!(subject: "Out of Coffee Filters", age: 3)
    
    EmployeeTicket.create!(employee_id: @christina_aguilera.id, ticket_id: @broken_printer.id)
    EmployeeTicket.create!(employee_id: @bobby_flay.id, ticket_id: @broken_printer.id)
    EmployeeTicket.create!(employee_id: @christina_aguilera.id, ticket_id: @dropped_database.id)
    EmployeeTicket.create!(employee_id: @bobby_flay.id, ticket_id: @dropped_database.id)
    EmployeeTicket.create!(employee_id: @jimmy_fallon.id, ticket_id: @dropped_database.id)
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

  describe "#shared_ticket_employees" do
    it "can return a unique list of all other employees who share a single ticket" do
      query = @bobby_flay.shared_ticket_employees(@dropped_database)

      expect(query).to eq([@christina_aguilera, @jimmy_fallon])
    end
  end

  describe "#unique employees" do
    it "can return a unique list of employees who share any tickets with a given employees" do
      query = @bobby_flay.unique_employees

      expect(query).to eq([@christina_aguilera, @jimmy_fallon])
    end
  end
end