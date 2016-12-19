# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Colors Table

# Admins

if !User.where(role: "admin").any?
	User.create(email: "lmaurimtfbwy@gmail.com", password: ENV["admin_mauri_pwd"], password_confirmation: ENV["admin_mauri_pwd"], role: "admin", kind: "other")
end


# Nomenclators

if !Color.any?
	Color.create(name_en: "Blue", name_es: "Azul")
	Color.create(name_en: "Brown", name_es: "Carmelita")
	Color.create(name_en: "Coffe", name_es: "Cafe")
	Color.create(name_en: "Green", name_es: "Verde")
	Color.create(name_en: "Grey", name_es: "Gris")
end

if !Expertise.any?
	Expertise.create(name_en: "Acting", name_es: "Actuacion")
	Expertise.create(name_en: "Dance", name_es: "Baile")
	Expertise.create(name_en: "Singing", name_es: "Canto")
end

if !Language.any?
	Language.create(name_en: "English", name_es: "Ingles")
	Language.create(name_en: "French", name_es: "Frances")
	Language.create(name_en: "German", name_es: "Aleman")
	Language.create(name_en: "Spanish", name_es: "Espanol")
	Language.create(name_en: "Italian", name_es: "Italiano")
end

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

if !Nationality.any?
	Nationality.create(name_en: "Cuban", name_es: "Cubana")
end

if !Plan.any?
	Plan.create(target: "model", level: "free", priority: 10, album_professional_max: 5, album_polaroid_max: 5, video_max: 0)
	Plan.create(target: "model", level: "premium", priority: 5, album_professional_max: 15, album_polaroid_max: 5, video_max: 1)
	Plan.create(target: "contractor", level: "free", priority: 10, casting_photos_references_max: 5)
end

if !Province.any?
	Province.create(name_en: "Havana", name_es: "La Habana")
	Province.create(name_en: "Pinar del Rio", name_es: "Pinar del Rio")
	Province.create(name_en: "Matanzas", name_es: "Matanzas")
	Province.create(name_en: "Mayabeque", name_es: "Mayabeque")
end

if !Category.any?
	Category.create(name_en: "Fashion", name_es: "Moda")
	Category.create(name_en: "Real life & People", name_es: "Vida real & Gente")
end

if !ShoeSize.any?
	ShoeSize.create(gender: "Female", usa: "6.0", uk: "4.0", eur: "37.0")
end

if !ClothSize.any?
	ClothSize.create(gender: "Female", usa: "4.0", uk: "2.0", eur: "36.0")
end

