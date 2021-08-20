require "domain_routing"

Rails.application.routes.draw do
  root "placeholders#index"
  patch "/locale/:locale", action: :site_locale, controller: :locales, as: :site_locale
  put "/locale", action: :default_locale, controller: :locales, as: :default_locale

  get "/search", action: :search, controller: :searches
end
