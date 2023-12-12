class TranslationsController < ApplicationController
    before_action :set_translation, only: [:show, :edit, :update, :destroy]
  
    # GET /translations
    def index
      @translations = Translation.all
    end
  
    # GET /translations/1
    def show
    end
  
    # GET /translations/new
    def new
      @translation = Translation.new
    end
  
    # POST /translations
    def create
      @translation = Translation.new(translation_params)
      if @translation.save
        redirect_to @translation, notice: 'Translation was successfully created.'
      else
        render :new
      end
    end
  
    private
      def set_translation
        @translation = Translation.find(params[:id])
      end
  
      def translation_params
        params.require(:translation).permit(:block_id, :language, :title, :description)
      end
  end
  