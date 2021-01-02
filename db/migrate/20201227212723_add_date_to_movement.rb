class AddDateToMovement < ActiveRecord::Migration[5.2]
  def change
    change_table :movements do |t|
      t.date :date
    end
    Movement.find_each do |m|
      m.update!(date: m.created_at.to_date)
    end
    change_column_null :movements, :date, false
  end
end
