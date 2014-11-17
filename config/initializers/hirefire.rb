HireFire.configure do |config|
  config.max_workers = 5
  config.job_worker_ratio = [
    { :when => lambda {|jobs| jobs < 2 }, :workers => 1 },
    { :when => lambda {|jobs| jobs < 4 }, :workers => 2 },
    { :when => lambda {|jobs| jobs < 6 }, :workers => 3 },
    { :when => lambda {|jobs| jobs < 8 }, :workers => 4 }
  ]
end