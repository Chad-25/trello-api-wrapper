module Trello
  module Resources
    class Board
      attr_accessor :id, :name, :url, :permission_level

      def initialize(data)
        @id = data['id']
        @name = data['name']
        @url = data['shortUrl']
        @permission_level = data['prefs']['permissionLevel']
      end
    end
  end
end
