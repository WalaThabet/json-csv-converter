require 'minitest/autorun'
require_relative 'json_to_csv_converter'

class JSONToCSVConverterTest < Minitest::Test
  def setup
    @converter = JSONToCSVConverter.new
  end

  def test_get_nested_values
    item = {"user" => {"name" => "Alice"}}
    header = "user.name"
    expected = "Alice"

    result = JSONToCSVConverter.new.send(:get_nested_values, item, header)
    assert_equal expected, result
  end

  def test_get_keys
    hash = {"user" => {"name" => "Alice"}, "company" => "My job glasses"}
    expected = ["user.name", "company"]

    result = JSONToCSVConverter.new.send(:get_keys, hash)
    assert_equal expected, result
  end
end
