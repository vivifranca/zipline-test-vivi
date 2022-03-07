# frozen_string_literal: true

require 'csv'

# Class responsible for any interaction with the CSV file
class MatcherCsv
  # reads a csv file and store the rows in memory
  def self.read(csv_file_path)
    csv_records = []
    CSV.foreach(csv_file_path, headers: true) do |row|
      csv_records << row.to_h
    end

    csv_records
  end

  # creates a csv file based on the file path and content
  def self.write(output_csv_path, csv_content)
    csv_headers = csv_content.first.keys
    grouped_csv = [csv_headers] + csv_content.map(&:values)

    File.write(output_csv_path, grouped_csv.map(&:to_csv).join)
  end
end
