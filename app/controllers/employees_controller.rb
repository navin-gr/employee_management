class EmployeesController < ApplicationController
  before_filter :find_employee, only: [:edit, :update, :destroy]
  
  #--
  # Purpose :- To get all Employees records
  #++ 
  def index
    @emp = Employee.all 
    @emp = @emp.like(params[:filter]) if params[:filter]
  end
  
  def new
    @emp = Employee.new 
  end

  def show    
    @emp = Employee.find(params[:emp_id])
  end
  
  #--
  # Purpose :- To  create employee
  #++  
  def create
    @emp = Employee.new(employee_params)
    if @emp.valid?
      @emp.save
      EmployeesWorker.perform_async(@emp.id)
      render 'show'
    else
      render 'new'
    # purpose:- To show Errors when validations fails on any attribute.
    end
  end
  
  #--
  # Purpose :- To update created employees
  #++
  def update
    @emp.update(employee_params)
    if @emp.valid?
      render 'show'
    else
      render 'new'
      #purpose:- To show Errors when validations fails on any attribute.
    end
  end


  #--
  # Purpose :- To Delete created employees
  #++
  def destroy
    @emp.destroy
    redirect_to root_path
  end

  private
 
    #--
    # Purpose :- To find created employees
    #++
    def find_employee
      @emp = Employee.find(params[:emp_id]) 
    end

    #--
    # Purpose :- To provide strong parameter for creating and updating Employee
    #++
    def employee_params
      params.require(:employee).permit(:name, :email, :designation, :mentor, :profile_image, :profile_image_cache, :remove_profile_image, :remote_profile_image_url)
    end
end
 

