class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :votable, polymorphic: true, index: true
      t.integer :value

      t.timestamps null: false
    end
  end
end
