require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Apps" do
  api_key = FactoryGirl.create(:api_key)
  header "Content-Type", "application/json"

  get "/v1/apps" do
    before do
      2.times {
        FactoryGirl.create(:app)
      }
    end

    example_request "Getting a list of apps" do
      response_body.should eq App.all_visible.to_json
      status.should eq 200
    end
  end

  get "/v1/apps/:id" do
    app = FactoryGirl.create(:app)

    let(:id) { app.id }

    example_request "Getting a specific app" do
      response_body.should == app.to_json
      status.should == 200
    end
  end

  post "/v1/apps" do
    header "Authorization", "Token token=#{api_key.access_token}"

    parameter :dataset_uris, "Dataset uris separados por comma"
    parameter :challenge_url, "Url del challenge"
    parameter :codebase_url, "Url del código fuente open source"
    parameter :demo_url, "Url del demo de la app"
    parameter :description, "Descripción de la app"
    parameter :name, "Nombre de la app"
    parameter :creators, "Twitter de los creadores separados por comma"
    parameter :organization, "Organización que creo la app"
    parameter :location, "Ubicación de los creadores"
    parameter :logo_url, "Logo de la app"
    parameter :visible, "Parametro para fistrar apps en el showcase"
    parameter :technologies, "Tecnologias usadas en la app separadas por comma"

    payload = {
      'app'=>{
        "dataset_uris" =>  "da4877f0-0a05-49b3-bf59-d8fd2896566c,ea8ce3be-db31-46b3-84f5-657b71a8e657",
        "challenge_url" =>  "http://codeandomexico.org/organizaciones/17/retos/71-aplicacion-movil-infancia-cuenta",
        "codebase_url" =>  "https://github.com/CodeandoMexico/apps-api",
        "demo_url" =>  "https://cmx-apps-staging.herokuapp.com/",
        "description" =>  "API for community gallery of open data & civic apps at Codeando Mexico",
        "name" =>  "Apps Api",
        "creators" =>  "Codeando Mexico,Adrian",
        "organization" =>  "cmx",
        "location" =>  "Monterrey",
        "logo_url" =>  "https://avatars2.githubusercontent.com/u/2940113?s=140",
        "visible" =>  true,
        "technologies" =>  "Rails,rails-api"
      }
    }

    let(:raw_post) { payload.to_json }

    example_request "Create an App" do
      explanation "Create an App, returns the created app"
      response_body.should be_json_eql(
        payload["app"].to_json
      )
      status.should eq 201
    end

  end

  patch "v1/apps/:id" do
    app = FactoryGirl.create(:app)

    header "Authorization", "Token token=#{api_key.access_token}"

    parameter :dataset_uris, "Dataset uris separados por comma"
    parameter :challenge_url, "Url del challenge"
    parameter :codebase_url, "Url del código fuente open source"
    parameter :demo_url, "Url del demo de la app"
    parameter :description, "Descripción de la app"
    parameter :name, "Nombre de la app"
    parameter :creators, "Twitter de los creadores separados por comma"
    parameter :organization, "Organización que creo la app"
    parameter :location, "Ubicación de los creadores"
    parameter :logo_url, "Logo de la app"
    parameter :visible, "Parametro para fistrar apps en el showcase"
    parameter :technologies, "Tecnologias usadas en la app separadas por comma"

    payload = {
      'app'=>{
        "name" =>  "Apps Api Updated Name",
      }
    }

    let(:id) { app.id }
    let(:raw_post) { payload.to_json }

    example_request "Update an App" do

      JSON.parse(response_body)["name"].should eql(
        payload["app"]["name"]
      )
      status.should eq 202
    end

  end

  delete "v1/apps/:id" do
    app = FactoryGirl.create(:app)

    header "Authorization", "Token token=#{api_key.access_token}"

    let(:id) { app.id }

    example_request "Deleting an app" do
      status.should == 204
    end
  end

  post "/v1/apps", :document => false do
    example_request "Fail to create an App without valid app key" do
      status.should eq 401
    end
  end
  patch "v1/apps/1", :document => false do
    example_request "Fail to update an App without valid app key" do
      status.should eq 401
    end
  end
  delete "v1/apps/1", :document => false do
    example_request "Fail to delete an App without valid app key" do
      status.should eq 401
    end
  end
end
