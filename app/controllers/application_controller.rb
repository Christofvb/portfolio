class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_locale

  private

  def set_locale
    if params[:locale].present? && available_locales.include?(params[:locale].to_sym)
      I18n.locale = params[:locale].to_sym
      session[:user_locale] = I18n.locale.to_s
    elsif session[:user_locale].present? && available_locales.include?(session[:user_locale].to_sym)
      I18n.locale = session[:user_locale].to_sym
    else
      I18n.locale = :fr
    end
  end

  def available_locales
    %i[fr nl en]
  end
end
