namespace :calculate do
  desc 'Activate and deactivate campaigns based on start/end dates'
  task amortizations: :environment do
    CreditPlan.where(state: 'En Proceso').each do |cp|
      puts cp.id
      monto = cp.amount
      plazos = cp.months
      taza = cp.credit_line.annual_interest/100.0
      
      a = (1+taza) ** (plazos*-1)
      cuota_fija = monto/((1-a)/taza)
      
      intereses = monto*taza
      total_amortizado = cuota_fija-intereses
      balance =  monto-total_amortizado
      amortizado = cuota_fija-intereses
      

      errors = false
      for i in 1..plazos
        fee = cp.fees.new
        fee.month = i
        fee.interest = intereses.to_i
        fee.amortization = amortizado.to_i
        fee.payment = cuota_fija.to_i
        fee.balance = balance.to_i
        
        intereses = balance*taza
        amortizado = cuota_fija-intereses
        total_amortizado = total_amortizado+amortizado
        balance =  monto-total_amortizado
        
        unless fee.save   
          puts "fee no grabo: #{fee.inspect}"
          cp.fees.delete_all
          errors = true
          return
        end
      end
      
      unless errors
        cp.state = 'Procesado'
        cp.risk_level = Random.rand(10)
        cp.save
      end
      sleep(25)
      puts "."
    end
    puts "done"
  end
end
