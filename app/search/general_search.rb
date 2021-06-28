module GeneralSearch
  extend ActiveSupport::Concern

  REFERENCE_TABLES = []
  SEARCH_FIELDS = [:name]

  included do
    scope :by_ids, -> (ids){ where id: ids }
    after_commit :reindex_model
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

    def autocomplete_value
      "#{name}"
    end

    def should_index?
      true
    end

    def reindex_model
      reindex
    end
  end

  def search_data
    {
      name: name
    }
  end
end
