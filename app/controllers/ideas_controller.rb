class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote, :estados, :comentarios, :update_etapa]
  before_action :authenticate_persona!, only: [:edit, :update, :destroy, :vote, :update_etapa]
  before_action :set_ability
  before_action :set_etapa, only: [:update_etapa]
   
  def index
    @ideas = Idea.order("created_at DESC").all
    @idea = Idea.new
    @etapas = Etapa.all
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
      format.js
    end
  end
  
  def new    
  end
  
  def create
    @mensajes  = []
    
    # if not persona_signed_in?
    #     @mensajes << "Necesitás estar logueado."
    #     
    #     respond_to do |format|
    #         format.js
    #     end
    # end
      
    # if @ability.can? :create, Idea
    @idea = Idea.new(idea_params)
    @idea.etapa = Etapa.first
    
    if persona_signed_in?
      @idea.persona_id = current_persona.id
    else 
      @idea.persona_id = Persona.find_by(email: 'pobrecito@hablador.com').id
      @mensajes << "Logueate para publicar con tu nombre."
    end
    
    @idea.texto.strip!
    @bloquear = true
    
    if @idea.texto.length == 0
      @mensajes << "No escribiste nada!"
    elsif @idea.texto.length < 3
      @mensajes << "No menos de 3 carácteres!"
    elsif @idea.texto.length > 300
      @mensajes << "No más de 300 carácteres!"
    elsif @idea.categoria.nil?
      @mensajes << "No elegiste una etiqueta!"
    else
      @bloquear = false
    end
    
    if not @bloquear
      respond_to do |format|
        if @idea.save
          @idea = Idea.find(@idea.id)
          
          format.html { redirect_to root_path }
          format.json { render :show, status: :created, location: @idea }
          format.js
        else
          format.html { redirect_to root_path, notice: 'Hubo un error. No se pudo guardar la idea :(' }
          format.json { render json: @idea.errors, status: :unprocessable_entity }
          format.js
        end
      end
    else
      respond_to do |format|
          format.js
      end
    end
    # else
    #   Rails.logger.debug("NOT AUTHORIZED ")
    # end
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
      if @ability.can? :update, Idea
        
          @idea = Idea.new(idea_params)
          @idea.persona_id = current_persona.id
          
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
  end
  
  def destroy
    @idea.destroy
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Idea eliminada.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  def vote
    if current_persona.voted_for?(@idea)
      current_persona.unvote_for(@idea)
    else 
      current_persona.vote_exclusively_for(@idea)
    end

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
      format.js
    end
  end
  
  def estados
    @estados = @idea.estados
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: @estados.to_json({:include => :persona}) }
      format.js
    end
  end
  
  def comentarios
    @comentarios = @idea.comentarios
    
    respond_to do |format|
        format.html { redirect_to root_path }
        format.json { head :no_content }
        format.js
     end
  end
  
  def update_etapa
    if @ability.can? :update, Idea
       @idea.etapa_id = @etapa.id
       
       respond_to do |format|
        if @idea.save          
          Rails.logger.debug("EXITO!")
          format.html { redirect_to root_path }
          format.json
          format.js
        else
          Rails.logger.debug("ERROR!")
          format.html { redirect_to root_path, notice: 'Hubo un error. No se pudo cambiar la etapa :(' }
          format.json { head :no_content }
          format.js
        end
      end
    end
  end
  
  def tv
    @ideas = Idea.order("created_at DESC").all
    @idea = Idea.new
  end
  
  private
  
    def set_idea
        @idea = Idea.find(params[:id])
    end
    
    def set_ability
        @ability = Ability.new(current_persona)
    end
       
    def set_etapa
        @etapa = Etapa.find(params[:etapa_id])
    end
    
    def idea_params
        params.require(:idea).permit(:texto, :categoria_id)
    end
end
