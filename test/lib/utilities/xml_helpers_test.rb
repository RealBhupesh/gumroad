# frozen_string_literal: true

require "test_helper"

# Ported from spec/lib/utilities/xml_helpers_spec.rb (#5801).
class XmlHelpersTest < ActiveSupport::TestCase
  test "gets the text of the element in simple xml" do
    xml_raw = %(<?xml version="1.0" encoding="utf-8"?><root><element>the text</element></root>)
    xml_document = REXML::Document.new(xml_raw)

    assert_equal "the text", XmlHelpers.text_at_xpath(xml_document, "root/element")
  end

  test "returns nil when the element is not found in simple xml" do
    xml_raw = %(<?xml version="1.0" encoding="utf-8"?><root><element>the text</element></root>)
    xml_document = REXML::Document.new(xml_raw)

    assert_nil XmlHelpers.text_at_xpath(xml_document, "root/elements")
  end

  test "gets the text of the first repeating element" do
    xml_raw = %(<?xml version="1.0" encoding="utf-8"?><root><element>a text block</element><element>the text</element></root>)
    xml_document = REXML::Document.new(xml_raw)

    assert_equal "a text block", XmlHelpers.text_at_xpath(xml_document, "root/element")
  end
end
