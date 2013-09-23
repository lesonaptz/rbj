class CreateAuthtokens < ActiveRecord::Migration
  def change
    create_table :authtokens do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :email
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
