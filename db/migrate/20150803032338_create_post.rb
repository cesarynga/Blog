class CreatePost < ActiveRecord::Migration
	def change
		create_table :posts do |t|
			t.string :title
			t.string :description
			t.references :user, null: false, index: true, foreign_key: true

			t.timestamps
		end
	end
end
