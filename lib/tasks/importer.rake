desc "Import movies"
task :import_movies => :environment do
  Movie.import_all
end