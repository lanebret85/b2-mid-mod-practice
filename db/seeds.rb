# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
it = Department.create!(name: "IT", floor: "Basement")

christina_aguilera = it.employees.create!(name: "Christina Aguilera", level: 2)
bobby_flay = it.employees.create!(name: "Bobby Flay", level: 3)

broken_printer = Ticket.create!(subject: "Printers Broken", age: 5)
dropped_database = Ticket.create!(subject: "Database Dropped", age: 1)
coffee_filters = Ticket.create!(subject: "Out of Coffee Filters", age: 3)

EmployeeTicket.create!(employee_id: christina_aguilera.id, ticket_id: broken_printer.id)
EmployeeTicket.create!(employee_id: bobby_flay.id, ticket_id: broken_printer.id)

EmployeeTicket.create!(employee_id: christina_aguilera.id, ticket_id: dropped_database.id)
EmployeeTicket.create!(employee_id: bobby_flay.id, ticket_id: dropped_database.id)

EmployeeTicket.create!(employee_id: bobby_flay.id, ticket_id: coffee_filters.id)