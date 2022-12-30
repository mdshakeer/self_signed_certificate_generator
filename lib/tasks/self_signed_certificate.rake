namespace :self_signed_certificate do

  task test_connection: :environment do
    include SelfSignedCertificateGenerator

    options = {
      expire_in_days: 1
    }

    puts HTTParty.get("http://localhost:3000/api/v1/certificates/expire_date", {
      query: {
        cert: generate_certificate(options)
      }
    })
  end

end
