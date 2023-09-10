require "rails_helper"

RSpec.describe "Departments Index Page", type: :feature do
  before :each do
    @it = Department.create!(name: "IT", floor: "Basement")
    @christina_aguilera = @it.employees.create!(name: "Christina Aguilera", level: 2)
    @bobby_flay = @it.employees.create!(name: "Bobby Flay", level: 3)
  end
  describe "As a user" do
    describe "When I visit the Department index page" do
      it "displays each department's name and floor, and underneath each department, I can see the names of all of its employees" do
        visit "/departments"
      
        expect(page).to have_content("All Departments")
        expect(page).to have_content("#{@it.name}")
        expect(page).to have_content("Floor: #{@it.floor}")
        expect(page).to have_content("#{@it.name} Employees:")
        expect(page).to have_content("#{@christina_aguilera.name}")
        expect(page).to have_content("#{@bobby_flay.name}")
      end
    end
  end
end