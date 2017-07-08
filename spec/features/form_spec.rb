require 'rails_helper'

RSpec.describe "ActiveAdminLatLng", type: :feature do
  it "render successfully" do
    coordinate = Coordinate.create! lat: '23.23121', lng: '43.32123'

    visit admin_coordinate_path(coordinate)

    expect(page).to have_text 'Coordinate'
    expect(page).to have_text '23.23121'
    expect(page).to have_text '43.32123'
  end
end
