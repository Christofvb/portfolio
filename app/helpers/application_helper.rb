module ApplicationHelper
  OG_LOCALES = { fr: "fr_FR", en: "en_US", nl: "nl_NL" }.freeze

  # Builds an absolute URL for the current page with a given locale param.
  # Pass nil to get the URL without any locale param (x-default / canonical).
  def locale_url(locale)
    base = "#{request.base_url}#{request.path}"
    locale ? "#{base}?locale=#{locale}" : base
  end

  def og_locale
    OG_LOCALES.fetch(I18n.locale.to_sym, "fr_FR")
  end
end
