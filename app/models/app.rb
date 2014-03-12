class App < ActiveRecord::Base

  before_create :parameterize_organization
  scope :all_visible, -> { where(visible: true) }
  #scope :filter_organization, -> (organization){ where(organization: organization) if organization }
  #scope :filter_location, -> (location){ where(location: location) if location }
  scope :filter, -> (filter, value){ where("#{filter} = ?", value) if value}
  #
  FILTER_CLASS = ['name','location','organization']

  def parameterize_organization
    self.organization = self.organization.parameterize
  end

end
