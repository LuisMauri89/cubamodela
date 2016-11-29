class Search < ApplicationRecord

  # Associations
  belongs_to :province
  belongs_to :nationality
  has_and_belongs_to_many :modalities, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy

  def perform(type)
  	case type
    when "models"
      return perform_models
    when "photographers"
      return perform_photographers      
    end
  end

  private
    def perform_models
      search = ProfileModel.all

      if province.present?
        search = search.where(province_id: self.province_id)
      end

      if nationality.present?
        search = search.where(nationality_id: self.nationality_id)
      end

      if gender.present?
        search = search.where(gender: self.gender)
      end

      console

      if age_from.present? && age_to.present?
        temp = []

        search.each do |pm|
          pm_age = pm.get_integer_age

          
          if pm_age > 0 && age_from <= pm_age && age_to >= pm_age
            temp << pm
          end
          
        end

        search = temp
      end

      if height_from.present? && height_to.present?
        temp = []

        search.each do |pm|
          pm_height = pm.height

          
          if pm_height.present? && height_from <= pm_height && height_to >= pm_height
            temp << pm
          end
          
        end

        search = temp
      end

      if modalities.any?
        temp = []

        search.each do |pm|
          pm_modalities = pm.modalities.map{ |pm_m| pm_m.name_en }
          modalities.map { |m| m.name_en }.each do |modality|
            if pm_modalities.include?(modality)
              temp << pm

              break
            end
          end
        end

        search = temp
      end

      if categories.any?
        temp = []

        search.each do |pm|
          pm_categories = pm.categories.map{ |pm_c| pm_c.name_en }
          categories.map { |c| c.name_en }.each do |category|
            if pm_categories.include?(category)
              temp << pm
              
              break
            end
          end
        end

        search = temp
      end


      return search
    end

    def perform_photographers
      search = ProfilePhotographers.all
      return search
    end
end
