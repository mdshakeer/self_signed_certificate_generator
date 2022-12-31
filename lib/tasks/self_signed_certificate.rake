namespace :self_signed_certificate do

  task test_connection: :environment do
    include SelfSignedCertificateGenerator

    options = {
      expire_in_days: 90
    }

    begin
      response = HTTParty.get("http://localhost:3000/api/v1/certificates/expire_date", {
        query: {
          cert: generate_certificate(options)
        }
      }).parsed_response
    rescue
      puts "Test connection failed"
    else
      puts "Test connection success: expiration date is: #{response['expire_date']}, Is expired: #{response['is_expired']}"
    end
  end

end
