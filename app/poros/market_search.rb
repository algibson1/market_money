class MarketSearch
  attr_reader :state, :city, :name

  def initialize(search_terms)
    @state = search_terms["state"]#&.capitalize
    @city = search_terms["city"]#&.capitalize
    @name = search_terms["name"]#&.capitalize
  end

  def valid?
    return false if @city && @state.nil?
    true
  end

  def render_queries
    queries = [query_sql]
    queries << "%#{@state}%" if @state
    queries << "%#{@city}%" if @city
    queries << "%#{@name}%" if @name
    queries
  end

  def query_sql
    query_statement = []
    query_statement << "LOWER(state) LIKE LOWER(?)" if @state
    query_statement << "LOWER(city) LIKE LOWER(?)" if @city
    query_statement << "LOWER(name) LIKE LOWER(?)" if @name
    query_statement.join(" AND ")
  end
end