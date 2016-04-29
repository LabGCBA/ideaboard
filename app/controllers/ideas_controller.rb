class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote, :estados, :comentarios]
  before_action :authenticate_persona!, only: [:edit, :update, :destroy, :vote]
  before_action :set_ability
  # before_action :authenticate_persona!, only: [:edit, :update, :destroy, :vote, :unvote]
   
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
    if not persona_signed_in?
        @mensaje = "Necesitás estar logueado."
        
        respond_to do |format|
            format.js
        end
    end
      
    if @ability.can? :create, Idea
      @idea = Idea.new(idea_params)
      @idea.persona_id = current_persona.id
      @idea.etapa = Etapa.first
      
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
    
    def idea_params
        params.require(:idea).permit(:texto, :categoria_id)
    end
end
