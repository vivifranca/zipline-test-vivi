#!/usr/bin/env ruby
# frozen_string_literal: true

require 'highline/import'
require 'bundler/setup'

$LOAD_PATH << File.expand_path("#{File.dirname(__FILE__)}/../lib")

require 'matcher'
require 'matcher_csv'

ALL_MATCHING_TYPES = {
  email: %i[email],
  phone: %i[phone],
  email_phone: %i[email phone]
}.freeze

# in case you'd like to test other file, please add here:
FILES = {
  input1: 'csv_files/input1.csv',
  input2: 'csv_files/input2.csv',
  input3: 'csv_files/input3.csv'
  # input4: 'csv_files/input4.csv'
}.freeze

# method responsible to run the csv matcher
def call
  file = prompt_choose(FILES, 'csv file to be processed')
  matching_type = prompt_choose(ALL_MATCHING_TYPES, 'matching type')

  csv_records = MatcherCsv.read(file)

  Matcher.call(csv_records, matching_type)

  csv_path = output_csv_path(File.basename(file, '.csv'), matching_type)
  MatcherCsv.write(csv_path, csv_records)
end

# method responsible to show matching type and file options on the prompt
def prompt_choose(options, description)
  result = ''
  puts
  choose do |menu|
    menu.prompt = "Please select the #{description}"
    options.each do |key, value|
      menu.choice(key) { result = value }
    end
  end
end

def output_csv_path(current_filename, matching_type)
  matchers = matching_type.join('-').to_s
  filename = "output-#{current_filename}-#{matchers}"
  "csv_files/#{filename}.csv"
end

call
