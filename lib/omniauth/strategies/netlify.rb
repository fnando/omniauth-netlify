# frozen_string_literal: true

require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Netlify < OmniAuth::Strategies::OAuth2
      option :name, "netlify"

      option :client_options,
             authorize_url: "https://app.netlify.com/authorize",
             token_url: "https://api.netlify.com/oauth/token"

      def authorize_params
        super.tap do |params|
          params[:client_id] = client.id
          params[:redirect_uri] ||= callback_url
        end
      end

      uid do
        info[:id]
      end

      info do
        {
          id: raw_info.fetch(:id),
          email: raw_info.fetch(:email),
          name: raw_info.fetch(:full_name)
        }
      end

      extra do
        raw_info
      end

      def token_params
        OmniAuth::Strategy::Options.new(
          code: request.params["code"],
          redirect_uri: callback_url,
          client_id: client.id,
          client_secret: client.secret,
          type: "web_server"
        )
      end

      def raw_info
        @raw_info ||= deep_symbolize(
          access_token.get("https://api.netlify.com/api/v1/user").parsed
        )
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
