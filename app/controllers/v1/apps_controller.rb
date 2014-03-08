module V1
  class AppsController < ApplicationController
    def index
      @apps = App.all
      render json: @apps
    end

    def show
      @app = App.find(params[:id])
      render json: @app
    end

    def new
      @app = App.new
      render json: @app
    end

    def update
      @app = App.find(params[:id])

      if @app.update_attributes(params[:app])
        head :no_content
      else
        render json: @app.errors, status: :unprocessable_entity
      end
    end

    def create
      @app = App.new(params[:app])

      if @app.save
        render json: @app, status: :created, location: @app
      else
        render json: @app.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @app = App.find(params[:id])
      @app.destroy

      head :no_content
    end
  end
end
