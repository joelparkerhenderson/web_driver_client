defmodule WebDriverClient.W3CWireProtocolClient.GuardsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias WebDriverClient.W3CWireProtocolClient.Guards

  require WebDriverClient.W3CWireProtocolClient.Guards

  property "is_session_id/1 only returns true on binaries" do
    check all term <- term() do
      if is_binary(term) do
        assert Guards.is_session_id(term)
      else
        refute Guards.is_session_id(term)
      end
    end
  end

  property "is_url/1 only returns true on binaries" do
    check all term <- term() do
      if is_binary(term) do
        assert Guards.is_url(term)
      else
        refute Guards.is_url(term)
      end
    end
  end

  @element_location_strategies [:css_selector, :xpath]

  property "is_element_location_strategy/1 only returns on known values" do
    check all term <-
                one_of([
                  term(),
                  member_of(@element_location_strategies)
                ]) do
      if term in @element_location_strategies do
        assert Guards.is_element_location_strategy(term)
      else
        refute Guards.is_element_location_strategy(term)
      end
    end
  end

  property "is_element_selector/1 only returns true on binaries" do
    check all term <- term() do
      if is_binary(term) do
        assert Guards.is_element_selector(term)
      else
        refute Guards.is_element_selector(term)
      end
    end
  end

  property "is_attribute_name/1 only returns true on binaries" do
    check all term <- term() do
      if is_binary(term) do
        assert Guards.is_attribute_name(term)
      else
        refute Guards.is_attribute_name(term)
      end
    end
  end

  property "is_property_name/1 only returns true on binaries" do
    check all term <- term() do
      if is_binary(term) do
        assert Guards.is_property_name(term)
      else
        refute Guards.is_property_name(term)
      end
    end
  end

  property "is_cookie_name/1 only returns true on binaries" do
    check all term <- term() do
      if is_binary(term) do
        assert Guards.is_cookie_name(term)
      else
        refute Guards.is_cookie_name(term)
      end
    end
  end

  property "is_cookie_value/1 only returns true on binaries" do
    check all term <- term() do
      if is_binary(term) do
        assert Guards.is_cookie_value(term)
      else
        refute Guards.is_cookie_value(term)
      end
    end
  end
end
