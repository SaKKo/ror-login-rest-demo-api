class Api::AppController < ApplicationController
  before_action :set_locale
  rescue_from JWT::DecodeError, with: :jwt_failed
  rescue_from JWT::ExpiredSignature, with: :jwt_failed
  rescue_from JWT::ImmatureSignature, with: :jwt_failed
  rescue_from JWT::InvalidIssuerError, with: :jwt_failed
  rescue_from JWT::InvalidIatError, with: :jwt_failed
  rescue_from JWT::VerificationError, with: :jwt_failed
  rescue_from GKError, with: :handle_gk_error
  rescue_from GKAuthenticationError, with: :handle_gk_authentication_error
  rescue_from GKUserNotFoundError, with: :handle_gk_authentication_error
  rescue_from GKNotAuthorizedError, with: :handle_gk_authentication_error
  rescue_from ActionController::ParameterMissing, with: :handle_other_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid_error

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def jwt_failed(exception)
    render json: { success: false, error: exception.to_s }, status: :unauthorized and return
  end

  def handle_gk_error(exception)
    render json: { success: false, error: exception.message }, status: :bad_request and return
  end

  def handle_gk_authentication_error(exception)
    render json: { success: false, error: exception.message }, status: :unauthorized and return
  end

  def handle_not_found_error(exception)
    render json: { success: false, error: exception.message }, status: :not_found and return
  end

  def handle_other_error(exception)
    render json: { success: false, error: exception.message }, status: :bad_request and return
  end

  def handle_record_invalid_error(exception)
    render json: { success: false, error: exception.message, details: exception.record.errors.as_json }, status: :bad_request and return
  end

  def handle_invalid_transition_error(exception)
    render json: { success: false, error: exception.message }, status: :bad_request and return
  end
end
