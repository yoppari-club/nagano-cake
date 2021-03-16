class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      
      t.integer :custemer_id
      t.string :shipping_postcode
      t.string :shipping_address
      t.string :shipping_name
      
      
      t.timestamps
    end
  end
end
