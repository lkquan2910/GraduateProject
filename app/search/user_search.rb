module UserSearch
  extend ActiveSupport::Concern
  REFERENCE_TABLES = []
  SEARCH_FIELDS = [:full_name, :email, :group_id]

  included do
    after_commit :reindex_user
    searchkick word_middle: SEARCH_FIELDS,
               suggest: SEARCH_FIELDS,
               searchable: SEARCH_FIELDS
    scope :search_import, -> { includes(REFERENCE_TABLES) }

    def self.search_result(str_query)
      str_query = str_query.split(' - ')
      search_name = search str_query[0],
                  fields: [:full_name, :email],
                  match: :word_middle,
                  misspellings: { below: 0 }

      search_email = search str_query[1],
                  fields: [:full_name, :email],
                  match: :word_middle,
                  misspellings: { below: 0 }

      by_ids((search_name.pluck(:id) + search_email.pluck(:id)).uniq).order(email: :asc)
    end

    def self.autocomplete_result(str_query)
      search(str_query,
             fields: [:email],
             match: :word_middle,
             misspellings: { below: 0 },
             suggest: true).map { |p| { value: p.autocomplete_value } }
    end

    # Search for Account
    def self.account_autocomplete_result(str_query)
      str_query = str_query.split(' - ')
      search_name = search(str_query[0],
             fields: [:full_name, :email],
             match: :word_middle,
             misspellings: { below: 0 },
             suggest: true).map { |p| { value: p.autocomplete_value } }

      search_email = search(str_query[1],
             fields: [:full_name, :email],
             match: :word_middle,
             misspellings: { below: 0 },
             suggest: true).map { |p| { value: p.autocomplete_value } }
      (search_name + search_email).uniq
    end

    def self.assignee_search_result str_query, avatar: true
      str_query = '*' if str_query.blank?
      result = search(str_query,
        fields: [:full_name, :email],
        where: {id: User.current.super_admin? ? User.all.pluck(:id) : User.current.descendant_ids},
        match: :word_middle,
        misspellings: {below: 0})
      if avatar
        result.map{|p| {id: p.id, text: p.full_name, avatar: p.get_avatar}}
      else
        result.map{|p| {id: p.id, text: p.full_name}}
      end
    end

    def autocomplete_value
      "#{full_name} - #{email}"
    end

    def should_index?
      true
    end

    def reindex_user
      reindex
    end
  end

  def search_data
    {
      full_name: full_name,
      email: email,
      account_type: account_type,
      is_superadmin: is_superadmin
    }
  end
end
