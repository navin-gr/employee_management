class EmployeesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: false

  #sidekiq_options :queue => :queue-name

  # recurrence { hourly.minute_of_hour(0, 5, 10, 15) }



  def perform(emp_id)
    emp = Employee.where(emp_id).first
    UserMailer.welcome_email(emp.email).deliver_now
  end
end