# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    page = params[:page]&.to_i&.then { _1.positive? ? _1 : 1 } || 1

    books = BookMongo.paginate(page)

    render json: BookSerializer.new(books).serialize
  end
end