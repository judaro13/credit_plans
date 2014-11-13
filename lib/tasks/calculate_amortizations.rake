namespace :calculate do
  desc 'Activate and deactivate campaigns based on start/end dates'
  task amortizations: :environment do
    puts 'Begining'
    while true
      sqs = AWS::SQS.new
      queue = sqs.queues.named("Worker")
      queue.receive_message(wait_time_seconds: 20) do |received_message|
        puts 'Message!'
        message = JSON.parse(received_message.body)
        credit_plan = CreditPlan.find(message['plan_id'])
        
        if credit_plan.state == 'En Proceso'
          credit_plan.calculate_fees
        end
        received_message.delete
        sleep(25)    
        puts 'done'
      end
    end
  end
end