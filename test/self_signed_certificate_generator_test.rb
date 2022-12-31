require "test_helper"
class SelfSignedCertificateGeneratorTest < ActionDispatch::IntegrationTest
  include SelfSignedCertificateGenerator

  test "returns correct options" do
    options = {
      expire_in_days: nil
    }
    assert_equal DEFAULT_CA_OPTIONS, set_options(options)

    options = {
      expire_in_days: 'abc'
    }
    assert_equal DEFAULT_CA_OPTIONS, set_options(options)

    options = {
      expire_in_days: []
    }
    assert_equal DEFAULT_CA_OPTIONS, set_options(options)

    options = {
      expire_in_days: 1
    }
    assert_equal DEFAULT_CA_OPTIONS.merge({
      expire_in_days: 1
    }), set_options(options)
  end

  test "`generate_certificate` should return a valid certificate" do
    cert = generate_certificate
    x509 = OpenSSL::X509::Certificate.new(cert)
    assert_kind_of OpenSSL::X509::Certificate, x509

    options = {
      expire_in_days: nil
    }
    cert = generate_certificate(options)
    x509 = OpenSSL::X509::Certificate.new(cert)
    assert_kind_of OpenSSL::X509::Certificate, x509

    options = {
      expire_in_days: 'abc'
    }
    cert = generate_certificate(options)
    x509 = OpenSSL::X509::Certificate.new(cert)
    assert_kind_of OpenSSL::X509::Certificate, x509

    options = {
      expire_in_days: 1
    }
    cert = generate_certificate(options)
    x509 = OpenSSL::X509::Certificate.new(cert)
    assert_kind_of OpenSSL::X509::Certificate, x509
  end

end