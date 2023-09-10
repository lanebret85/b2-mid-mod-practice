class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
  end

  def update
    EmployeeTicket.create!(employee_id: params[:id], ticket_id: params[:ticket_id])
    redirect_to "/employees/#{params[:id]}"
  end
end