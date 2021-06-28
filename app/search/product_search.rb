module ProductSearch
  extend ActiveSupport::Concern

  REFERENCE_TABLES = []
  SEARCH_FIELDS = [:code]

  included do
    after_commit :reindex_product
    searchkick word_middle: SEARCH_FIELDS, suggest: SEARCH_FIELDS
    scope :search_import, -> { includes(REFERENCE_TABLES) }

    def self.search_result str_query, level: 0
      search_results = search str_query,
        fields: SEARCH_FIELDS,
        match: :word_middle,
        misspellings: {below: 0},
        where: {level: level}

      by_ids(search_results.pluck(:id)).order(code: :asc)
    end

    def self.autocomplete_result str_query, level: 0
      search(str_query,
        fields: SEARCH_FIELDS,
        match: :word_middle,
        where: {level: level},
        misspellings: {below: 0},
        suggest: true).map{|p| {value: p.autocomplete_value}}
    end

    def self.select2_search_result str_query
      search(str_query,
        fields: SEARCH_FIELDS,
        match: :word_middle,
        where: {
          state: 'for_sale'
        },
        misspellings: {below: 0}).map{|p| {id: p.id, text: p.code}}
    end

    def autocomplete_value
      code
    end

    def reindex_product
      reindex
    end
  end

  def search_data
    {
      code: code,
      level: level,
      state: state
    }
  end
end
