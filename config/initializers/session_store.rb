# Be sure to restart your server when you modify this file.

CreditPlans::Application.config.session_store :cookie_store, key: '_creditPlans_session'

Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes