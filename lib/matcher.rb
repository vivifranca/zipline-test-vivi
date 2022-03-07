# frozen_string_literal: true

require 'pry-byebug'
require 'securerandom'

# class responsible to find the matchers from a csv file
class Matcher
  attr_reader :csv_records, :matching_type, :mapped_identifiers

  def self.call(csv_records, matching_type)
    new(csv_records, matching_type).call
  end

  def initialize(csv_records, matching_type)
    @csv_records = csv_records
    @matching_type = matching_type
    # mapped_identifiers will store: { matcher: identifier }
    # matcher: phone or email / identifier: Randon UUID
    @mapped_identifiers = {}
  end

  private_class_method :new

  # find the matches based on CSV file and matching criteria
  def call
    column_matchers = find_column_matchers

    csv_records.map! do |row|
      common_identifiers = ''
      row_identifiers = []

      column_matchers.each do |matcher|
        key = row[matcher]
        next if key.to_s.empty?

        row_identifiers << key_formatter(matcher, key)
      end

      row_identifiers.each do |id|
        if mapped_identifiers.key?(id)
          common_identifiers = id
          break
        end
      end

      row_identifier_found = mapped_identifiers[common_identifiers] || SecureRandom.uuid
      row['id'] = row_identifier_found

      row_identifiers.each { |id| mapped_identifiers[id] = row_identifier_found }

      row
    end
  end

  def find_column_matchers
    current_headers = csv_records.first.keys
    columns = []

    matching_type.each do |item|
      columns << current_headers.find_all { |h| h.downcase.to_s.include? item.to_s }
    end

    columns.flatten!
    raise StandardError, 'Invalid matchers' if columns.empty?

    columns
  end

  def key_formatter(key_type, key)
    key_type == :phone ? key&.gsub(/[^0-9]+/, '') : key
  end
end
