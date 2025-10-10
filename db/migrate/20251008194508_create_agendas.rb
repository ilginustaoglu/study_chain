class CreateAgendas < ActiveRecord::Migration[6.1]
  def change
    create_table :agendas do |t|
      t.string :title
      t.text :description
      t.datetime :event_date

      t.timestamps
    end
  end
end
