# app/controllers/employee_sessions_controller.rb
class EmployeeSessionsController < Devise::SessionsController
    def create
      super do |user|
        # Check if user is an employee.
        unless user.employee
          sign_out user
          flash[:alert] = "Only employee can connect!"
          flash[:notice] = nil # reset notice
          redirect_to new_user_session_path and return
        end
      end
    end
  end
  
  