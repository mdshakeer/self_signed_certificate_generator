require 'rubygems'
require 'openssl'

module SelfSignedCertificateGenerator
	def generate_subject(opts)
		subject = ""
    subject << "/C=#{opts[:country]}" if opts[:country]
    subject << "/ST=#{opts[:state]}" if opts[:state]
    subject << "/O=#{opts[:org]}" if opts[:org]
    subject << "/OU=#{opts[:org_unit]}" if opts[:org_unit]
    subject << "/CN=#{opts[:common_name]}" if opts[:common_name]
    subject << "/emailAddress=#{opts[:email]}" if opts[:email]
    subject
	end

	def generate(opts = {})
		key = OpenSSL::PKey::RSA.new(2048)
		options = DEFAULT_CA_OPTIONS.merge(opts)
		subject = generate_subject(options)

		cert = OpenSSL::X509::Certificate.new
    cert.subject = cert.issuer = OpenSSL::X509::Name.parse(subject)
    cert.not_before = Time.now
    cert.not_after = Time.now + options[:expire_in_days] * 24 * 60 * 60
    cert.public_key = key.public_key
    cert.serial = 0x0
    cert.version = 2

    ef = OpenSSL::X509::ExtensionFactory.new
    ef.subject_certificate = ef.issuer_certificate = cert
    cert.add_extension ef.create_extension("basicConstraints","CA:TRUE", true)
    cert.add_extension ef.create_extension("subjectKeyIdentifier", "hash")
    cert.add_extension ef.create_extension("authorityKeyIdentifier", "keyid:always,issuer:always")

    cert.sign key, OpenSSL::Digest::SHA256.new
    puts cert.to_pem
	end

end