require "test_helper"

class Api::V1::CertificatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_certificates_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_certificates_show_url
    assert_response :success
  end

  test "should get expire_date" do
    get api_v1_certificates_expire_date_url
    assert_response :success
  end
end
