class CreateAllowedIps < ActiveRecord::Migration
  def change
    create_table :allowed_ips do |t|
      t.string :name
      t.string :ip_address

      t.timestamps
    end
  end
end
