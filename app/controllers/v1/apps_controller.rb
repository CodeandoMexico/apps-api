module V1
  class AppsController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :restrict_access, only: [:update, :create, :destroy]
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def index
      @apps = App.all_visible
      request.GET.each do |key, value|
        @apps = @apps.filter(key,value)
      end
      render json: @apps
    end

    def show
      render json: @app
    end

    def update
      if @app.update(app_params)
        render json: @app, status: :accepted
      else
        render json: @app.errors, status: :unprocessable_entity
      end
    end

    def create
      @app = App.new(app_params)

      if @app.save
        render json: @app, status: :created
      else
        render json: @app.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @app.destroy

      head :no_content, status: :ok
    end

  private

    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end
    end

    def set_article
      @app = App.find(params[:id])
    end

    def app_params
      params.require(:app).permit(:dataset_uris, :challenge_url, :codebase_url, :demo_url, :description, :name, :creators, :organization, :location, :logo_url, :visible)
    end
  end
end
