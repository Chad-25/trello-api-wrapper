module Trello
  module Resources
    class Card
      attr_accessor :id, :name, :url, :desc

      def initialize(data)
        @id = data['id']
        @name = data['name']
        @url = data['url']
        @desc = data['desc']
      end
    end
  end
end
