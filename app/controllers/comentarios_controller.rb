class ComentariosController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_idea, only: [:create]
  before_action :authenticate_persona!, only: [:edit, :update, :destroy]
  before_action :set_ability

  def index
  end
  
  def new
  end
  
  def create
    @comentario = Comentario.new(comment_params)
    
    if persona_signed_in?
      @comentario.persona_id = current_persona.id
    else 
      @comentario.persona_id = Persona.find_by(email: 'pobrecito@hablador.com').id
      @mensajes = []
      @mensajes << "Logueate para comentar con tu nombre."
    end
    
    @comentario.texto.strip!
    @bloquear = true
    
    if @comentario.texto.length == 0
      @mensajes << "No escribiste nada!"
    elsif @comentario.texto.length < 3
      @mensajes << "No menos de 3 carácteres!"
    elsif @comentario.texto.length > 300
      @mensajes << "No más de 300 carácteres!"
    else
      @bloquear = false
    end

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
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
      format.js
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @id = @comentario.id
    @comentario.destroy
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Comentario eliminado.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  private
  
    def set_comment
        @comentario = Comentario.find(params[:id])
    end
    
    def set_idea
        @idea = Idea.find(params.require(:comentario).permit(:texto, :idea_id)[:idea_id])
    end
    
    def set_ability
        @ability = Ability.new(current_persona)
    end

    def comment_params
        params.require(:comentario).permit(:texto, :idea_id)
    end
end
