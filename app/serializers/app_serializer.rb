class AppSerializer < ActiveModel::Serializer
  attributes :id, :dataset_uris, :challenge_url, :codebase_url, :demo_url, :description, :name, :creators, :organization, :location, :logo_url, :visible, :created_at, :updated_at, :technologies
end
