namespace :tickets do
  desc "Generate made-up tickets via email"
  task :generate_via_email do
    require "pony"
    to_address = ENV.fetch('TO', 'help@turfcasts.com')

    time = Time.now
    issues = %w[Issue Problem Trouble Danger Disaster Catastrophe Speedbump Aggravation Bug Annoyance Fail]

    50.times do |j|
      i = j + 50
      subject = "#{issues.sample} - #{i}"
      puts "sending subject #{subject}"

      Pony.mail({
        to: to_address,
        subject: "#{issues.sample} - #{i}",
        body: "Hi,\n\n#{time}: #{subject}\n\nThanks!",
        via: :smtp,
        via_options: {
          address:              'smtp.gmail.com',
          port:                 '587',
          enable_starttls_auto: true,
          user_name:            ENV.fetch('GMAIL_USERNAME') { raise "No GMAIL_USERNAME configured" },
          password:             ENV.fetch('GMAIL_PASSWORD') { raise "No GMAIL_PASSWORD configured" },
          authentication:       :plain, # :plain, :login, :cram_md5, no auth by default
          domain:               "localhost.localdomain" # the HELO domain provided by the client to the server
        }
      })
      sleep 0.5
    end
  end
end
