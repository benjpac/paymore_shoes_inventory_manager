class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.column :name, :string

      t.timestamps
    end

    create_table :models do |t|
      t.column :brand_id, :integer
      t.column :name, :string
      t.column :price, :integer

      t.timestamps
    end

    create_table :inventory do |t|
      t.column :model_id, :integer
      t.column :store_id, :integer
      t.column :amount, :integer

      t.timestamps
    end

    create_table :stores do |t|
      t.column :name, :string

      t.timestamps
    end

  end
end
