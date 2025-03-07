# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    page = params[:page]&.to_i&.then { _1.positive? ? _1 : 1 } || 1
    per_page = Settings.app.items_per_page || 10

    offset = (page - 1) * per_page

    books = Book.order(:id).offset(offset).limit(per_page)

    render json: BookSerializer.new(books).serialize
  end
end