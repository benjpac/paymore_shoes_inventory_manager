require 'spec_helper'

describe('Checks brand / model association', :type => :feature) do
  it "adds a brand and then a model to that brand" do
    visit('/')
    fill_in("brand", with: "Nike")
    click_button("Add Brand")
    expect(page).to have_content('Nike')
    fill_in("name", with: "jordan")
    fill_in("price", with: 120)
    click_button("Add Model")
    expect(page).to have_content('Jordan')
  end
end

describe('Adds a store', :type => :feature) do
  it "adds a store" do
    visit('/')
    fill_in("store", with: "store")
    click_button("Add Store")
    expect(page).to have_content('Store')
  end
end
