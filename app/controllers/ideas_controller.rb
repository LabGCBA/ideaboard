class IdeasController < ApplicationController
  def index
    @all = Idea.all
    @idea = Idea.first
  end
  
  def new
  end
  
  def create
    @idea = Idea.new(idea_params)
    
    @idea.persona_id = 1
    
    if @idea.save
      flash[:success] = "Idea guardada!"
    else
      flash[:error] = "Hubo un error. No se pudo guardar la idea :("    end
    
    redirect_to root_path
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    idea = Idea.find(params[:id])
    if idea.update_attributes(idea_params)
      flash[:success] = "Idea guardada!"
    else
      flash[:error] = "Hubo un error. No se pudo guardar la idea :("
    end
    redirect_to root_path
  end
  
  def destroy
    Idea.find(params[:id]).destroy
    flash[:success] = "Idea eliminada"
    redirect_to root_path
  end
  
  private
  def idea_params
    params.require(:idea).permit(:texto)
  end
end
