class CreateContactIms < ActiveRecord::Migration
  def self.up
    create_table :contact_ims do |t|
      t.integer :person_id
      t.string :url
      t.integer :type

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_ims
  end
end
