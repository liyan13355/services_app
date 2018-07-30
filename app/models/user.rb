class User < ApplicationRecord
  include Clearance::User


  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
  						:available_filters => %w[
  							sorted_by
  							search_query
  							with_country_id
  							with_created_at_gte
  						]

  self.per_page = 3

  belongs_to :country


    scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("users.created_at #{ direction }")
    when /^last_name_/
      order("LOWER(users.last_name) #{ direction }")
    when /^country_name_/
      order("LOWER(countries.name) #{ direction }").includes(:country).references(:country)
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :search_query, lambda { |query|
  	return nil  if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e| 
			(e.gsub('*', '%') + '%').gsub(/%+/, '%')
			} 
			num_or_conditions = 3
			where(
				terms.map {
          or_clauses = [
          "LOWER(users.first_name) LIKE ?",
          "LOWER(users.last_name) LIKE ?",
          "LOWER(users.email) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :with_country_id, lambda { |country_ids|
    where(country_id: [*country_ids])
  }
  scope :with_created_at_gte, lambda { |ref_date|
    where('users.created_at >= ?', ref_date)
  }

  

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'last_name_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      ['Country (a-z)', 'country_name_asc']
    ]
  end

  def full_name
    [last_name, first_name].compact.join(', ')
  end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

end
