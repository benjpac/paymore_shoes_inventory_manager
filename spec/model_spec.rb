require 'spec_helper'

describe Model do
  it { should belong_to(:brand) }
  it { should have_many(:stores) }

  it 'validates presence of name and price' do
    model = Model.new(name: "", price: nil)
    expect(model.save).to eq(false)
  end
  it 'creates a brand and two models that belong to that brand' do
    brand = Brand.create(name: "Nike")
    model = brand.models.create(name: "2017 jordan", price: 120)
    model1 = brand.models.create(name: "2017 Jordan", price: 120)
    expect(model.brand).to eq(brand)
    expect(brand.models).to eq([model, model1])
  end
  it 'captalizes on before save' do
    model = Model.create(name: 'test shoe', price: 12)
    expect(model.name).to eq('Test Shoe')
  end
end
