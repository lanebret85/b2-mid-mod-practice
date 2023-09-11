require "rails_helper"

RSpec.describe "Employees Show Page", type: :feature do
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
    EmployeeTicket.create!(employee_id: @bobby_flay.id, ticket_id: @coffee_filters.id)
  end

  describe "As a user" do
    describe "When I visit the Employee show page" do
      it "displays the employee's name, their level, and their department, and I see a list of all of their tickets from oldest to newest. I also see the oldest ticket assigned to the employee listed separately" do
        visit "/employees/#{@bobby_flay.id}"
      
        expect(page).to have_content("Employee: #{@bobby_flay.name}")
        expect(page).to have_content("Level: #{@bobby_flay.level}")
        expect(page).to have_content("Department: #{@bobby_flay.department.name}")
        expect(page).to have_content("Tickets:")
        expect(@broken_printer.subject).to appear_before(@coffee_filters.subject)
        expect(@coffee_filters.subject).to appear_before(@dropped_database.subject)
        expect(page).to have_content("Oldest Ticket: #{@broken_printer.subject}")
      end

      it "does not display any tickets that are not assigned to the employee and I see a form to add a ticket to this employee" do
        visit "/employees/#{@christina_aguilera.id}"

        expect(page).to_not have_content(@coffee_filters.subject)
        expect(page).to have_content("Add a ticket for this employee")
      end

      it "displays a unique list of all the other employees that this employee shares tickets with" do
        visit "/employees/#{@bobby_flay.id}"

        expect(page).to have_content("Other employees sharing tickets:")
        expect(page).to have_content("#{@christina_aguilera.name}")
        expect(page).to_not have_content("#{@jimmy_fallon.name}")
      end
    end

    describe "When I fill in the form with the id of a ticket that already exists in the database and I click submit" do
      it "redirects me to that employees show page and I see the ticket's subject now listed" do
        visit "/employees/#{@christina_aguilera.id}"

        fill_in :ticket_id, with: @coffee_filters.id

        click_on "Submit"

        expect(current_path).to eq("/employees/#{@christina_aguilera.id}")
        expect(page).to have_content(@coffee_filters.subject)
      end
    end
  end
end