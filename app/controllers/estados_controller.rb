class EstadosController < ApplicationController
  before_action :set_ability
  
  def index
  end
  
  def new
  end
  
  def create
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
      def set_ability
          @ability = Ability.new(current_persona)
      end
end
