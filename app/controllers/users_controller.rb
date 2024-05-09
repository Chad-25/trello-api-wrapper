class UsersController < ApplicationController
  before_action :trello_client, only: [:index, :show]
  # before_action :trello_client, only: [:index, :show, :edit, :update]

  def index
    @current_user = trello_client.current_trello_user
  end

  def show
    @board = trello_client.get_board(params[:format])
  end

  def show_cards
    @cards = trello_client.get_cards(params[:id])
  end

  private

  def trello_client
    @trello_client ||= Trello::V1::Client.new
  end

end
