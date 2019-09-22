class CreateFollowedUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :followed_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :to, null: false

      t.timestamps
    end

    add_foreign_key :followed_users, :users, column: :to_id, primary_key: :id
  end
end
