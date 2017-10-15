module Tacos
  class Filterer
    attr_reader :options
    FILTER_ATTRIBUTES = %i[
      name
      spicy
      double_tortilla
      meat
    ].freeze

    IS_SPICY = "true".freeze
    NOT_SPICY = "false".freeze

    attr_accessor *FILTER_ATTRIBUTES

    delegate :options_for_spicyness_select,
             :options_for_meat_select,
             to: :class

    def self.options_for_spicyness_select
      ["All"] + Taco.spicy_options
    end

    def self.options_for_meat_select
      ["All"] + Taco.meat_options
    end

    def initialize(attributes = {}, **options)
      attributes.to_h.each do |name, value|
        send("#{name}=", value)
      end

      @options = options
    end

    def tacos
      @tacos ||= arel_builder.arel
    end

    def arel_builder
      ArelBuilder.new(self)
    end

    class ArelBuilder < DelegateClass(self.class)
      def initialize(filterer)
        super(filterer)
      end

      def arel
        @arel ||= begin
          arel = base_arel
          arel = filter_on_name(arel) if name.present?
          arel = filter_on_spicy(arel) if spicy.present?
          arel = filter_on_meat(arel) if meat.present?

          arel
        end
      end

      def base_arel
        options.fetch(:base_arel)
      end

      private

      def filter_on_name(arel)
        arel.for_name(name)
      end

      def filter_on_spicy(arel)
        case spicy
        when IS_SPICY
          arel.is_spicy
        when NOT_SPICY
          arel.is_not_spicy
        else
          arel
        end
      end

      def filter_on_meat(arel)
        if Taco.meat_options.include?(meat)
          arel.for_meat(meat)
        else
          arel
        end
      end
    end

  end
end
