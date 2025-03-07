# frozen_string_literal: true

class BookSerializer
  include Alba::Resource

  root_key :book

  attributes :id, :title, :insno
end