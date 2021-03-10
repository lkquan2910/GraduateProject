module ProjectSearch
  extend ActiveSupport::Concern

  REFERENCE_TABLES = []
  SEARCH_FIELDS = [:name, :full_address, :investor, :city, :district, :ward, :street]
  FILTER_FIELDS = [:real_estate_type, :furnitures, :features]

  included do
    after_commit :reindex_product
    searchkick word_middle: SEARCH_FIELDS,
               suggest: SEARCH_FIELDS,
               filterable: FILTER_FIELDS,
               searchable: SEARCH_FIELDS
    scope :search_import, -> { includes(REFERENCE_TABLES) }

    def self.search_result str_query, level: 0
      search_results = search str_query,
                              fields: [:name],
                              match: :word_middle,
                              misspellings: {below: 0}

      by_ids(search_results.pluck(:id)).order(name: :asc)
    end

    def self.autocomplete_result str_query, level: 0
      search(str_query,
             fields: [:name],
             match: :word_middle,
             misspellings: {below: 0},
             suggest: true).map{|p| {value: p.autocomplete_value}}
    end

    def self.select2_search_result str_query
      search(str_query,
             fields: [:name, :full_address],
             match: :word_middle,
             misspellings: {below: 0}).map{|p| {id: p.id, text: p.name}}
    end

    def autocomplete_value
      name
    end

    def should_index?
      true
    end

    def reindex_product
      reindex
    end
  end

  def search_data
    {
      name: name,
      full_address: full_address,
      real_estate_type: real_estate_type,
      min_price: min_price_filter,
      max_price: max_price_filter,
      min_acreage: min_acreage_filter,
      max_acreage: max_acreage_filter,
      furnitures: furnitures,
      features: features,
      online_transaction: online_transaction,
      investors: investors,
      investor: Investor.where(id: investors).pluck(:name).join(', '),
      city: region&.city&.name,
      district: region&.district&.name,
      ward: region&.ward&.name,
      street: region&.street
    }
  end
end
