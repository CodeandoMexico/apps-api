module V1
  class AppsController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_filter :restrict_access, only: [:update, :create, :destroy]
    def index
      @apps = App.all
      render json: @apps
    end

    def show
      @app = App.find(params[:id])
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

  private

    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end
    end
  end
end
