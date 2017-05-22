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
  @brand = Brand.find(params[:brand_id].to_i)
  erb :brand
end

get '/store/:store_id' do
  @brands = Brand.all
  @store = Store.find(params[:store_id].to_i)
  erb :store
end

get '/store/:store_id/brand/:brand_id' do
  @brands = Brand.all
  @store = Store.find(params[:store_id].to_i)
  @brand = Brand.find(params[:brand_id].to_i)
  erb :store
end

get '/store/:store_id/brand/:brand_id/model/:model_id' do
  @brands = Brand.all
  @store = Store.find(params[:store_id].to_i)
  @brand = Brand.find(params[:brand_id].to_i)
  @model = Model.find(params[:model_id].to_i)
  erb :store
end

post '/store/new' do
  name = params[:store]
  store = Store.create(name: name)
  if store.save
    redirect '/store/'+store.id.to_s
  else
    erb :index
  end
end

post '/brand/new' do
  name = params[:brand]
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

post '/store/:store_id/select_brand' do
  store = Store.find(params[:store_id].to_i)
  brand = Brand.find(params[:brand_id].to_i)
  redirect '/store/'+store.id.to_s+'/brand/'+brand.id.to_s
end

post '/store/:store_id/brand/:brand_id/select_model' do
  store = Store.find(params[:store_id].to_i)
  brand = Brand.find(params[:brand_id].to_i)
  model = Model.find(params[:model_id].to_i)
  redirect '/store/'+store.id.to_s+'/brand/'+brand.id.to_s+'/model/'+model.id.to_s
end

post '/clear_all' do
  clear_all
  @stores = Store.all
  @brands = Brand.all
  erb :index
end

patch '/store/:store_id/brand/:brand_id/model/:model_id' do
  store = Store.find(params[:store_id].to_i)
  brand = Brand.find(params[:brand_id].to_i)
  model = Model.find(params[:model_id].to_i)
  store.models.push(model)
  model_inventory = store.inventories.where(model: model.id).first
  model_inventory.update(amount: params[:quantity].to_i)
  redirect '/store/'+store.id.to_s
end

def convert_to_cents(string)
  string.tr!("$", "")
  if string.include?(".")
    string.tr!(".", "")
    return string.to_i
  else
    return string.to_i * 100
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
