namespace :fda do
  desc "TODO"
  task import_data: :environment do
    puts "Importing data..."

    FdaDownloader.new(url: "http://www.accessdata.fda.gov/premarket/ftparea/public.zip").import_data

    puts "Finished"
    puts "#{Clinic.count} clinics imported"
  end
end
