require 'spec_helper'

describe Store do
  it { should have_many(:models) }

  it 'validates presence of name' do
    store = Store.new(name: '')
    expect(store.save).to eq(false)
  end
  it 'creates a store that is associated a model' do
    brand = Brand.create(name: 'Nike')
    model = brand.models.create(name: "2017 Jordan", price: 120)
    expect(model.brand).to eq(brand)
    store = model.stores.create(name: 'Tukwila')
    expect(store.models).to eq([model])
  end
end
