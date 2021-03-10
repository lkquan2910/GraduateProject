module CustomerSearch
  extend ActiveSupport::Concern

  REFERENCE_TABLES = []
  SEARCH_FIELDS = [:name, :phone_number, :name_and_phone]

  included do
    after_commit :reindex_customer
    searchkick word_middle: SEARCH_FIELDS, suggest: SEARCH_FIELDS
    scope :search_import, -> { includes(REFERENCE_TABLES) }

    def self.search_result str_query
      search_results = search str_query,
                              fields: SEARCH_FIELDS,
                              match: :word_middle,
                              misspellings: {below: 0}

      by_ids(search_results.pluck(:id)).order(name: :asc)
    end

    def self.autocomplete_result str_query
      search(str_query,
             fields: SEARCH_FIELDS,
             match: :word_middle,
             misspellings: {below: 0},
             suggest: true).map{|p| {value: p.autocomplete_value}}
    end

    def self.select2_search_result str_query
      search(str_query,
             fields: SEARCH_FIELDS,
             match: :word_middle,
             misspellings: {below: 0}).map{|p| {id: p.id, text: p.name, phone_number: p.phone_number}}
    end

    def autocomplete_value
      "#{name} - #{phone_number}"
    end

    def should_index?
      true
    end

    def reindex_customer
      reindex
    end
  end

  def search_data
    {
      name_and_phone: name_and_phone,
      name: name,
      phone_number: phone_number
    }
  end
end
