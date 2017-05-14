require 'bundler/setup'
Bundler.require :default
also_reload 'lib/**/*.rb'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @brands = Brand.all
  @stores = Store.all
  erb :index
end

get '/brand/:brand_id' do
  @brand = Brand.find(params['brand_id'].to_i)
  erb :brand
end

get '/store/:store_id' do
  @store = Store.find(params['store_id'].to_i)
  erb :store
end

post '/store/new' do
  name = params[:name]
  store = Store.create(name: name)
  if store.save
    redirect '/store/'+store.id.to_s
  else
    erb :index
  end
end

post '/brand/new' do
  name = params[:name]
  brand = Brand.create(name: name)
  if brand.save
    redirect '/brand/'+brand.id.to_s
  else
    erb :index
  end
end

post '/brand/:brand_id/model/new' do
  brand = Brand.find(params[:brand_id].to_i)
  name = params[:name]
  price = convert_to_cents(params[:price])
  model = brand.models.create(name: name, price: price)
  if model.save
    redirect '/brand/'+brand.id.to_s
  else
    erb :brand
  end
end

post '/clear_all' do
  clear_all
  @brands = Brand.all
  erb :index
end

def convert_to_cents(string)
  string.tr!("$", "")
  if string.include?(".")
    string.tr!(".", "")
    return string.to_i()
  else
    return string.to_i() * 100
  end
end

def convert_to_money(cents)
  string = "$" + cents.to_s()
  return string.insert(-3, ".")
end

def clear_all
  Brand.delete_all
  Inventory.delete_all
  Model.delete_all
  Store.delete_all
end
