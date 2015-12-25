class EmployeesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  #sidekiq_options :queue => :critical

  def perform(emp)
    UserMailer.welcome_email(emp["email"]).deliver_now
  end
end