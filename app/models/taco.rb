class Taco < ApplicationRecord
  scope :for_name, -> name {
    where(arel_table[:name].matches("%#{name.downcase}%"))
  }
  scope :for_spicy, -> spicy {
    where(arel_table[:spicy].eq(spicy))
  }
  scope :for_meat, -> meat {
    where(arel_table[:meat].matches("%#{meat.downcase}%"))
  }
  scope :is_spicy, -> {
    for_spicy(true)
  }
  scope :is_not_spicy, -> {
    for_spicy(false)
  }

  def self.spicy_options
    ["true", "false"].freeze
  end

  def self.meat_options
    [
      "Pork",
      "Beef",
      "Chicken"
      ].freeze
  end
end
