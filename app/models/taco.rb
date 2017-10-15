class Taco < ApplicationRecord
  SPICYNESS = ["true", "false"].freeze
  MEATS = ["Pork", "Beef", "Chicken"].freeze
  scope :for_name, -> name {
    where(arel_table[:name].matches("%#{name.downcase}%"))
  }
  scope :for_spicy, -> spicy {
    where(arel_table[:spicy].eq(spicy))
  }
  scope :for_meat, -> meat {
    where(arel_table[:meat].matches("%#{meat.downcase}%"))
  }
end
