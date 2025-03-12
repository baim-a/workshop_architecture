class BookMongo
  include Mongoid::Document

  field :title, type: String
  field :series, type: String
  field :insno, type: String
  field :language, type: String
  field :authors, type: Array
  field :genres, type: Array

  scope :paginate, -> (page, per_page = Settings.app.items_per_page) do
    offset = (page - 1) * per_page
    asc(:title).offset(offset).limit(per_page)
  end
end