require 'spec_helper'

describe Inventory do
  it { should belong_to(:model) }
  it { should belong_to(:store) }

  it 'returns inventory amount' do
    store = Store.create(name: 'Tukwila')
    model = store.models.create(name: 'Jordan 2016', price: 120)
    inventory = store.inventories.where(model: model.id).first
    inventory[:amount] = 1
    expect(inventory.amount).to eq(1)
  end
end
