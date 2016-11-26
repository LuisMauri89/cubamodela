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


      return search
    end

    def perform_photographers
      search = ProfilePhotographers.all
      return search
    end
end
