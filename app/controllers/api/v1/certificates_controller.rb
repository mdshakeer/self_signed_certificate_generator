class Api::V1::CertificatesController < ApplicationController
  def expire_date
    x509 = OpenSSL::X509::Certificate.new(params[:cert].to_s)
    render json: { expire_date: x509.not_after, is_expired: Time.now > x509.not_after, status: 200 }
  rescue OpenSSL::X509::CertificateError
    render json: { message: "Invalid Certificate Input" }, status: :unprocessable_entity
  end
end
