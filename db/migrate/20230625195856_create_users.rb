class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true, index: true
      t.string :email
      t.string :password_digest
      t.string :auth_token

      t.timestamps
    end
  end
end
