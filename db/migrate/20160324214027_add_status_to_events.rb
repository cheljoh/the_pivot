class AddStatusToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status, :string, default: 'upcoming'
  end
end
