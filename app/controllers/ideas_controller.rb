class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_persona!, only: [:edit, :update, :destroy]
  
  def index
    @ideas = Idea.order("created_at DESC").all
    @idea = Idea.new
  end
  
  def new    
  end
  
  def create
    @idea = Idea.new(idea_params)
    @idea.persona_id = 1
    @texto_original = @idea.texto.clone

    respond_to do |format|
      if @idea.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @idea }
        format.js
      else
        format.html { redirect_to root_path, notice: 'Hubo un error. No se pudo guardar la idea :(' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to root_path, notice: 'Idea guardada!' }
        format.json { render :show, status: :ok, location: @idea }
        format.js
      else
        format.html { redirect_to root_path, notice: 'Hubo un error. No se pudo guardar la idea :(' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Idea eliminada.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  
  private
  
    def set_idea
        @idea = Idea.find(params[:id])
    end

    def idea_params
        params.require(:idea).permit(:texto)
    end
end
