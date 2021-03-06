class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :imageurl
      t.string :created_at
      t.string :updated_at
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
