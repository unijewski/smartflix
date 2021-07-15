# frozen_string_literal: true

module Apis
  module Omdb
    class Base
      include HTTParty

      base_uri Rails.application.credentials.omdb_api_url

      default_params apikey: Rails.application.credentials.omdb_api_key

      headers 'Content-Type' => 'application/json'

      def call
        raise NoMethodError, :call
      end
    end
  end
end
