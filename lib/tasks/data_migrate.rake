namespace :data do
  namespace :migrate do
    task books_to_mongo: :environment do
      book_count = Book.count.to_f

      puts "Migration books started..."
      Book.includes(:authors, :language, :genres).in_batches do |books|
        index_books = books.map do |book|
          {
            title: book.title,
            series: book.series,
            insno: book.insno,
            authors: book.authors.map { "#{_1.last_name} #{_1.first_name} #{_1.middle_name}".strip },
            language: book.language.name,
            genres: book.genres.map(&:name),
          }
        end

        BookMongo.collection.insert_many(index_books)

        print "\rMigrated data: #{((BookMongo.collection.count / book_count) * 100).floor}%"
      end
      puts "\n"
      puts "Migration completed"
    end
  end
end