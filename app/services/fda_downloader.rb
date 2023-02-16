require "open-uri"
require "zip"

class FdaDownloader
  attr_accessor :url

  def initialize(url:)
    @url = url

    clean_data
  end

  def import_data
    content = open(url)

    Zip::File.open_buffer(content) do |zip|
      zip.each do |entry|
        read_data = entry.get_input_stream.read
        data = read_data.split("\r\n")

        save_data(data)
      end
    end
  end

  private

  def clean_data
    Clinic.delete_all
  end

  def save_data(data)
    ActiveRecord::Base.transaction do
      data.map do |row|
        clinic = row.split("|")

        Clinic.create!(
          facility: clinic[0],
          phone_number: clinic[7],
          city: clinic[4],
          zip_code: clinic[6]
        )
      end
    end
  end
end
