class EmployeesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: false

  #sidekiq_options :queue => :queue-name

  # recurrence { hourly.minute_of_hour(0, 5, 10, 15) }


  def perform
    puts "Executed in everythree minute....... :)"
  end


  # def perform(emp)
  #   UserMailer.welcome_email(emp["email"]).deliver_now
  # end
end