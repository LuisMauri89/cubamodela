class ChangeTranslationsTableCastings < ActiveRecord::Migration[5.0]
  def change
  	change_table :castings do |t|
  	  t.rename :title, :title_en
  	  t.rename :description, :description_en
  	  t.rename :location, :location_en
  	  t.string :title_es
  	  t.text :description_es
  	  t.text :location_es
	  end

	  change_column :castings, :description_en, :text
	  change_column :castings, :location_en, :text
  end
end
