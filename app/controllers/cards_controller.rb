class CardsController < ApplicationController
  before_action :find_card, only: [:edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def edit
  end

  def update
    puts params
    puts "============="
    if @card.update(cards_params)
      redirect_to cards_path
    else
      flash[:notice] = "Запись не может быть сохранена"
      render "edit"
    end
  end

  def create
    card = Card.new(cards_params)
    if card.save
      redirect_to root_path
    else
      flash[:notice] = "Запись не может быть сохранена"
      redirect_to root_path
    end  
  end

  def destroy
    @card.destroy
    redirect_to :back
  end

  def find_card
    @card = Card.find(params[:id])
  end

  private
  def cards_params
    params.require(:card).permit(:original_text, :translated_text)
  end  
end
