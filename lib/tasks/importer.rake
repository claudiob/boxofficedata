desc "Import movies"
task :import_movies => :environment do
  Movie.import_all
end

# desc "Import weekend results"
# task :import_weekends => :environment do
#   Weekend.import_all
# end