require "test_helper"

class Api::V1::CertificatesControllerTest < ActionDispatch::IntegrationTest
  include SelfSignedCertificateGenerator

  test "should get expire_date" do
    get api_v1_certificates_expire_date_url(cert: generate_certificate )
    assert_response :success
  end

  test "should return invalid message for errored certificate input" do
    get api_v1_certificates_expire_date_url(cert: "")
    resp = JSON.parse @response.body
    assert_equal 'Invalid Certificate Input', resp['message']
  end

  test "should return is_expired message as true for expired certificate" do
    options = {
      expire_in_days: -1
    }

    get api_v1_certificates_expire_date_url(cert: generate_certificate(options))
    resp = JSON.parse @response.body
    assert_equal true, resp['is_expired']
  end

  test "should return is_expired message as false for non expired certificate" do
    options = {
      expire_in_days: 1
    }

    get api_v1_certificates_expire_date_url(cert: generate_certificate(options))
    resp = JSON.parse @response.body
    assert_equal false, resp['is_expired']
  end
end
