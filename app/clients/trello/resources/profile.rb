module Trello
  module Resources
    class Profile
      attr_reader :id, :username, :full_name, :email, :initials, :id_boards

      def initialize(data)
        @id = data['id']
        @username = data['username']
        @full_name = data['fullName']
        @email = data['email']
        @initials = data['initials']
        @id_boards = data['idBoards']
      end
    end
  end
end
