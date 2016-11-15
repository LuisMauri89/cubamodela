# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Colors Table

# Site admins
# User.create(email: "lmaurimtfbwy@gmail.com", password: "Smotciss2307", password_confirmation: "Smotciss2307", role: "admin", kind: "other")


# Nomenclators

if !Ethnicity.any?
	Ethnicity.create(name_en: "Black/African roots", name_es: "Negro/Raices africanas")
	Ethnicity.create(name_en: "Chinese", name_es: "Chino")
	Ethnicity.create(name_en: "Indian/Pakistani", name_es: "Indio/Paquistani")
	Ethnicity.create(name_en: "Japanese/Korean", name_es: "Japones/Koreano")
	Ethnicity.create(name_en: "Latino/Hispanic", name_es: "Latino/Hispano")
	Ethnicity.create(name_en: "Middle Eastern", name_es: "Medio Oriente")
	Ethnicity.create(name_en: "Other", name_es: "Otra")
	Ethnicity.create(name_en: "Pacific Islander", name_es: "Pacifico")
	Ethnicity.create(name_en: "South Asian", name_es: "Asiatico sur")
	Ethnicity.create(name_en: "White/Caucasic", name_es: "Blanco/Caucasico")
end

if !Modality.any?
	Modality.create(name_en: "Swimsuit/Bikini", name_es: "Traje de bano/Bikini")
	Modality.create(name_en: "Glamour", name_es: "Glamur")
	Modality.create(name_en: "Catalog", name_es: "Catalogo")
	Modality.create(name_en: "Commercial", name_es: "")
	Modality.create(name_en: "Fitness", name_es: "Ejercicios")
	Modality.create(name_en: "Promotional", name_es: "Promocion")
	Modality.create(name_en: "Beauty", name_es: "Belleza")
	Modality.create(name_en: "Clothing", name_es: "Ropa")
	Modality.create(name_en: "Cover", name_es: "Portada")
end

if !Category.any?
	Category.create(name_en: "Fashion", name_es: "Moda")
	Category.create(name_en: "Real life & People", name_es: "Vida real & Gente")
end

if !ShoeSize.any?
	ShoeSize.create(gender: "Female", usa: "6.0", uk: "4", eur: "37")
end

