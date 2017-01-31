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
	User.create(email: "alejandropmauri@gmail.com", password: ENV["admin_ale_pwd"], password_confirmation: ENV["admin_ale_pwd"], role: "admin", kind: "other")
	User.create(email: "@gmail.com", password: ENV["admin_oscar_pwd"], password_confirmation: ENV["admin_oscar_pwd"], role: "admin", kind: "other")
end


# Nomenclators

if !Color.any?
	Color.create(name_en: "Hazelnut", name_es: "Avellana")
    Color.create(name_en: "Blue", name_es: "Azul")
	Color.create(name_en: "Brown", name_es: "Castaño")
	Color.create(name_en: "Black", name_es: "Negro")
	Color.create(name_en: "Green", name_es: "Verde")
	Color.create(name_en: "Grey", name_es: "Gris")
end

if !Expertise.any?
	Expertise.create(name_en: "Acting", name_es: "Actuación")
	Expertise.create(name_en: "Dance", name_es: "Baile")
	Expertise.create(name_en: "Singing", name_es: "Canto")
    Expertise.create(name_en: "Catwalk modeling", name_es: "Modelaje de Pasarela")
    Expertise.create(name_en: "Photography modeling", name_es: "Modelaje de Fotografía")
    Expertise.create(name_en: "Fit modeling", name_es: "Modelaje de Físico")
end

if !Language.any?
	Language.create(name_en: "English", name_es: "Inglés")
	Language.create(name_en: "French", name_es: "Francés")
	Language.create(name_en: "German", name_es: "Alemán")
	Language.create(name_en: "Spanish", name_es: "Español")
	Language.create(name_en: "Italian", name_es: "Italiano")
end

if !Ethnicity.any?
	Ethnicity.create(name_en: "Black/African roots", name_es: "Negro/Raíces africanas")
	Ethnicity.create(name_en: "Chinese", name_es: "Chino")
	Ethnicity.create(name_en: "Indian/Pakistani", name_es: "Indio/Paquistaní")
	Ethnicity.create(name_en: "Japanese/Korean", name_es: "Japones/Koreano")
	Ethnicity.create(name_en: "Latino/Hispanic", name_es: "Latino/Hispano")
	Ethnicity.create(name_en: "Middle Eastern", name_es: "Medio Oriente")
	Ethnicity.create(name_en: "Other", name_es: "Otra")
	Ethnicity.create(name_en: "Pacific Islander", name_es: "Pacífico")
	Ethnicity.create(name_en: "South Asian", name_es: "Asiático sur")
	Ethnicity.create(name_en: "White/Caucasic", name_es: "Blanco/Caucásico")
end

if !Modality.any?
	Modality.create(name_en: "Swimsuit/Bikini", name_es: "Traje de bano/Bikini")
    Modality.create(name_en: "Lingerie", name_es: "Lencería")
	Modality.create(name_en: "Glamour", name_es: "Glamur")
	Modality.create(name_en: "Catalog", name_es: "Catálogo")
	Modality.create(name_en: "Commercial", name_es: "Comercial")
	Modality.create(name_en: "Fitness", name_es: "Ejercicios")
	Modality.create(name_en: "Promotional", name_es: "Promoción")
	Modality.create(name_en: "Beauty", name_es: "Belleza")
	Modality.create(name_en: "Clothing", name_es: "Ropa")
	Modality.create(name_en: "Cover", name_es: "Portada")
end

if !Nationality.any?
	Nationality.create(name_en: "Cuban", name_es: "Cubana")
    Nationality.create(name_en: "North American", name_es: "Norteamericano")
    Nationality.create(name_en: "Spanish", name_es: "Español")
    Nationality.create(name_en: "Canadian", name_es: "Canadiense")
    Nationality.create(name_en: "Mexican", name_es: "Mexicano")
    Nationality.create(name_en: "French", name_es: "Frances")
    Nationality.create(name_en: "Italian", name_es: "Italiano")
    Nationality.create(name_en: "Turkish", name_es: "Turko")
    Nationality.create(name_en: "Rusian", name_es: "Ruso")
    Nationality.create(name_en: "British", name_es: "Británico")
    Nationality.create(name_en: "Chinese", name_es: "Chino")
    Nationality.create(name_en: "Other", name_es: "Otro")
end

if !Plan.any?
	Plan.create(target: "model", level: "free", priority: 10, album_professional_max: 5, album_polaroid_max: 5, video_max: 0)
	Plan.create(target: "model", level: "premium", priority: 5, album_professional_max: 15, album_polaroid_max: 5, video_max: 1)
	Plan.create(target: "photographer", level: "basic", priority: 10, album_professional_max: 5, video_max: 0)
	Plan.create(target: "photographer", level: "premium", priority: 5, album_professional_max: 15, video_max: 1)
	Plan.create(target: "contractor", level: "free", priority: 10, casting_photos_references_max: 5)
end



if !Province.any?
	Province.create(name_en: "Havana", name_es: "La Habana")
	Province.create(name_en: "Pinar del Rio", name_es: "Pinar del Río")
	Province.create(name_en: "Matanzas", name_es: "Matanzas")
	Province.create(name_en: "Mayabeque", name_es: "Mayabeque")
    Province.create(name_en: "Artemisa", name_es: "Artemisa")
    Province.create(name_en: "Santi Spiritus", name_es: "Santi Spíritus")
    Province.create(name_en: "Villa Clara", name_es: "Villa Clara")
    Province.create(name_en: "Camaguey", name_es: "Camaguey")
    Province.create(name_en: "Cienfuegos", name_es: "Ciengfuegos")
    Province.create(name_en: "Holguín", name_es: "Holguín")
    Province.create(name_en: "Las Tunas", name_es: "Las Tunas")
    Province.create(name_en: "Santiago de Cuba", name_es: "Santiago de Cuba")
    Province.create(name_en: "Guantánamo", name_es: "Guantánamo")
    Province.create(name_en: "Isla de la Juventud", name_es: "Isla de la Juventud")
end

if !Category.any?
	Category.create(name_en: "Fashion", name_es: "Moda")
	Category.create(name_en: "Real life & People", name_es: "Vida real & Gente")
    Category.create(name_en: "Bodypainting", name_es: "Pintura corporal")
    Category.create(name_en: "Underwater", name_es: "Bajo el agua")
    Category.create(name_en: "Sports", name_es: "Deporte")
    Category.create(name_en: "Fitness", name_es: "Físico")
    Category.create(name_en: "Hair/Makeup", name_es: "Peinados y Maquillaje")
    Category.create(name_en: "Art", name_es: "Arte")
end

if !ShoeSize.any?
	ShoeSize.create(gender: "Female", usa: "5.0", uk: "3.0", eur: "36.0")
    ShoeSize.create(gender: "Female", usa: "5.5", uk: "3.5", eur: "36.5")
    ShoeSize.create(gender: "Female", usa: "6.0", uk: "4.0", eur: "37.0")
    ShoeSize.create(gender: "Female", usa: "6.5", uk: "4.5", eur: "37.5")
    ShoeSize.create(gender: "Female", usa: "7.0", uk: "5.0", eur: "38.0")
    ShoeSize.create(gender: "Female", usa: "7.5", uk: "5.5", eur: "38.5")
    ShoeSize.create(gender: "Female", usa: "8.0", uk: "6.0", eur: "39.0")
    ShoeSize.create(gender: "Female", usa: "8.5", uk: "6.5", eur: "39.5")
    ShoeSize.create(gender: "Female", usa: "9.0", uk: "7.0", eur: "40.0")
    ShoeSize.create(gender: "Female", usa: "9.5", uk: "7.5", eur: "40.5")
    ShoeSize.create(gender: "Female", usa: "10.0", uk: "8.0", eur: "41.0")
    ShoeSize.create(gender: "Female", usa: "10.5", uk: "8.5", eur: "41.5")
    ShoeSize.create(gender: "Female", usa: "11.0", uk: "9.0", eur: "42.0")
    ShoeSize.create(gender: "Female", usa: "11.5", uk: "9.5", eur: "42.5")
    ShoeSize.create(gender: "Female", usa: "12.0", uk: "10.0", eur: "43.0")
    ShoeSize.create(gender: "Female", usa: "12.5", uk: "10.5", eur: "43.5")
    ShoeSize.create(gender: "Male", usa: "7.0", uk: "6.0", eur: "40.0")
    ShoeSize.create(gender: "Male", usa: "7.5", uk: "6.5", eur: "40.5")
    ShoeSize.create(gender: "Male", usa: "8.0", uk: "7.0", eur: "41.0")
    ShoeSize.create(gender: "Male", usa: "8.5", uk: "7.5", eur: "41.5")
    ShoeSize.create(gender: "Male", usa: "9.0", uk: "8.0", eur: "42.0")
    ShoeSize.create(gender: "Male", usa: "9.5", uk: "8.5", eur: "42.5")
    ShoeSize.create(gender: "Male", usa: "10.0", uk: "9.0", eur: "43.0")
    ShoeSize.create(gender: "Male", usa: "10.5", uk: "9.5", eur: "43.5")
    ShoeSize.create(gender: "Male", usa: "11.0", uk: "10.0", eur: "44.0")
    ShoeSize.create(gender: "Male", usa: "11.5", uk: "10.5", eur: "44.5")
    ShoeSize.create(gender: "Male", usa: "12.0", uk: "11.0", eur: "45.0")
    ShoeSize.create(gender: "Male", usa: "12.5", uk: "11.5", eur: "45.5")
    ShoeSize.create(gender: "Male", usa: "13.0", uk: "12.0", eur: "46.0")
    ShoeSize.create(gender: "Male", usa: "13.5", uk: "12.5", eur: "46.5")
    ShoeSize.create(gender: "Male", usa: "14.0", uk: "13.0", eur: "47.0")
    ShoeSize.create(gender: "Male", usa: "14.5", uk: "13.5", eur: "47.5")
    ShoeSize.create(gender: "Male", usa: "15.0", uk: "14.0", eur: "48.0")
    ShoeSize.create(gender: "Male", usa: "15.5", uk: "14.5", eur: "48.5")
end

if !ClothSize.any?
	ClothSize.create(gender: "Female", usa: "0.0", uk: "2.0", eur: "30.0")
    ClothSize.create(gender: "Female", usa: "0.0", uk: "4.0", eur: "32.0")
    ClothSize.create(gender: "Female", usa: "2.0", uk: "6.0", eur: "34.0")
    ClothSize.create(gender: "Female", usa: "4.0", uk: "8.0", eur: "36.0")
    ClothSize.create(gender: "Female", usa: "6.0", uk: "10.0", eur: "38.0")
    ClothSize.create(gender: "Female", usa: "8.0", uk: "12.0", eur: "40.0")
    ClothSize.create(gender: "Female", usa: "10.0", uk: "14.0", eur: "42.0")
    ClothSize.create(gender: "Female", usa: "12.0", uk: "16.0", eur: "44.0")
    ClothSize.create(gender: "Female", usa: "14.0", uk: "18.0", eur: "46.0")
    ClothSize.create(gender: "Male", usa: "34.0", uk: "34.0", eur: "44.0")
    ClothSize.create(gender: "Male", usa: "36.0", uk: "36.0", eur: "46.0")
    ClothSize.create(gender: "Male", usa: "38.0", uk: "38.0", eur: "48.0")
    ClothSize.create(gender: "Male", usa: "40.0", uk: "40.0", eur: "50.0")
    ClothSize.create(gender: "Male", usa: "42.0", uk: "42.0", eur: "52.0")
    ClothSize.create(gender: "Male", usa: "44.0", uk: "44.0", eur: "54.0")
    ClothSize.create(gender: "Male", usa: "46.0", uk: "46.0", eur: "56.0")
end

