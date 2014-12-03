class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :value
      t.integer :posts_id
      t.string  :posts_type
      t.timestamps
    end
  end
end
