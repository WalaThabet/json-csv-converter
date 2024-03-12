require 'json'
require 'csv'

class JSONToCSVConverter
  def initialize
    input_file_path = 'input_json_files/users.json'
    file_content = File.read(input_file_path)
    @parsed_json = JSON.parse(file_content)
  end

  def convert_json_to_csv
    CSV.open("output_csv_files/output.csv", "wb") do |csv|
      headers = @parsed_json.map {|row| get_keys(row) }.uniq.flatten
      # Header row
      csv << headers
      parsed_json.each do |item|
        row = []
        headers.each do |header|
          row << get_row_values(item, header)
        end
        csv << row
      end
    end
  end

  private

  def get_keys(hash, prefix='')
    keys = []
    # If the object is a hash:
    # - If prefix is empty it means we are at the parent node, so set the key as parent and add it to the array of keys
    # - If the value for that key is a hash , it means we have nested keys, set the prefix as the parent and recall function using the value as hash and parent as prefix
    # and so on
    hash.each do |key, value|
      full_key = prefix.empty? ? key : "#{prefix}.#{key}"
      keys << full_key unless value.is_a?(Hash)
      keys.concat(get_keys(value, full_key)) if value.is_a?(Hash)
    end
    keys
  end

  def get_nested_values(item, header)
    keys = header.split('.')
    current_value = item

    keys.each do |key|
      current_value = current_value[key]
    end
    current_value
  end

  def self.get_row_values(item, header)
    keys = header.split('.')
    if item.is_a?(Hash)
      value = get_nested_values(item, header)
      if value.is_a?(Array)
        value.join(', ')
      else
        value
      end
    elsif item.is_a?(Array)
      item.map(&:to_s).join(', ')
    else
      item[header]
    end
  end
end
