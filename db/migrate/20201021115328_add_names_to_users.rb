class AddNamesToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :position, length: 3
    end
  end
end
