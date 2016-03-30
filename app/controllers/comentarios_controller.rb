class ComentariosController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_idea, only: [:create]

  def index
  end
  
  def new
  end
  
  def create
    @comentario = Comentario.new(comment_params)
    @comentario.persona_id = 1

    respond_to do |format|
      if @comentario.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @comentario }
        format.js
      else
        format.html { redirect_to root_path, notice: 'Hubo un error. No se pudo guardar el comentario :(' }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
        format.js
      end
    end
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
  
    def set_comment
        @comentario = Comentario.find(params[:id])
    end
    
    def set_idea
        #@idea = Idea.find(params[:idea_id])
        @idea = Idea.find(params.require(:comentario).permit(:texto, :idea_id)[:idea_id])
    end

    def comment_params
        params.require(:comentario).permit(:texto, :idea_id)
    end
end
