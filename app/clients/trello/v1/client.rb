require 'faraday'
require 'json'

module Trello
  module V1
    class Client
      BASE_URL = 'https://api.trello.com/1'.freeze
      API_CREDENTIALS = Rails.application.credentials.trello_api_credentials

      def current_trello_user
        profile_data = request(
          method: :get,
          endpoint: "members/me",
          headers: { 'Accept' => 'application/json' }
        )
        Trello::Resources::Profile.new(JSON.parse(profile_data.body))
      end

      def get_board(board_id)
        board_details = request(
          method: :get,
          endpoint: "boards/#{board_id}"
        )
        Trello::Resources::Board.new(JSON.parse(board_details.body))
      end

      def get_cards(board_id)
        cards_info = request(
          method: :get,
          endpoint: "boards/#{board_id}/cards",
          headers: { 'Accept' => 'application/json' }
        )

        cards_data = JSON.parse(cards_info.body)
        cards = cards_data.map { | card_data | Trello::Resources::Card.new(card_data) }

        cards
      end

      private

      def connection
        @connection ||= Faraday.new(url: BASE_URL)
      end

      def request(method:, endpoint:, params: {}, headers: {}, body: {})
        response = connection.public_send(method, endpoint) do |request|
          request.params['key'] = API_CREDENTIALS[:api_key]
          request.params['token'] = API_CREDENTIALS[:token]
          request.headers = headers if headers.present?
          request.body = body.to_json if body.present?
        end
        response
      end
    end
  end
end
