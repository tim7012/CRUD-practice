class AddLogoToEvent < ActiveRecord::Migration
  def change
    add_attachment :events, :logo
  end
end
