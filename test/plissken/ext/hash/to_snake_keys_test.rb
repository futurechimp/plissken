# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../../test_helper.rb")

describe "Hash" do
  describe "with camelBack keys" do
    describe "which are JSON-style strings" do
      describe "in the simplest case" do
        before do
          @hash = { "firstKey" => "fooBar" }
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @hash.to_snake_keys
          end

          it "snakifies the key" do
            assert_equal("first_key", @snaked.keys.first)
          end

          it "leaves the key as a string" do
            assert_equal("first_key", @snaked.keys.first)
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @snaked.values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal("firstKey", @hash.keys.first)
          end
        end
      end

      describe "containing an array of other hashes" do
        before do
          @hash = {
            "appleType" => "Granny Smith",
            "vegetableTypes" => [
              { "potatoType" => "Golden delicious" },
              { "otherTuberType" => "peanut" },
              { "peanutNamesAndSpouses" => [
                { "billThePeanut" => "sallyPeanut" },
                { "sammyThePeanut" => "jillPeanut" }
              ] }
            ]
          }
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @hash.to_snake_keys
          end

          it "recursively snakifies the keys on the top level of the hash" do
            assert @snaked.key?("apple_type")
            assert @snaked.key?("vegetable_types")
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @snaked["apple_type"])
          end

          it "converts second-level keys" do
            assert @snaked["vegetable_types"].first.key? "potato_type"
          end

          it "leaves second-level values alone" do
            assert @snaked["vegetable_types"].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @snaked["vegetable_types"].last["peanut_names_and_spouses"]
                                             .first.key?("bill_the_peanut")
            assert @snaked["vegetable_types"].last["peanut_names_and_spouses"]
                                             .last.key?("sammy_the_peanut")
          end

          it "leaves third-level values alone" do
            assert_equal "sallyPeanut", @snaked["vegetable_types"]
              .last["peanut_names_and_spouses"]
              .first["bill_the_peanut"]
            assert_equal "jillPeanut", @snaked["vegetable_types"]
              .last["peanut_names_and_spouses"]
              .last["sammy_the_peanut"]
          end
        end
      end
    end

    describe "which are symbols" do
      describe "in the simplest case" do
        before do
          @hash = { firstKey: "fooBar" }
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @hash.to_snake_keys
          end

          it "snakifies the key" do
            assert_equal(:first_key, @snaked.keys.first)
          end

          it "leaves the key as a symbol" do
            assert_equal(:first_key, @snaked.keys.first)
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @snaked.values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal(:firstKey, @hash.keys.first)
          end
        end
      end

      describe "containing an array of other hashes" do
        before do
          @hash = {
            appleType: "Granny Smith",
            vegetableTypes: [
              { potatoType: "Golden delicious" },
              { otherTuberType: "peanut" },
              { peanutNamesAndSpouses: [
                { billThePeanut: "sallyPeanut" },
                { sammyThePeanut: "jillPeanut" }
              ] }
            ]
          }
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @hash.to_snake_keys
          end

          it "recursively snakifies the keys on the top level of the hash" do
            assert @snaked.key?(:apple_type)
            assert @snaked.key?(:vegetable_types)
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @snaked[:apple_type])
          end

          it "converts second-level keys" do
            assert @snaked[:vegetable_types].first.key? :potato_type
          end

          it "leaves second-level values alone" do
            assert @snaked[:vegetable_types].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @snaked[:vegetable_types].last[:peanut_names_and_spouses]
                                            .first.key?(:bill_the_peanut)
            assert @snaked[:vegetable_types].last[:peanut_names_and_spouses]
                                            .last.key?(:sammy_the_peanut)
          end

          it "leaves third-level values alone" do
            assert_equal "sallyPeanut", @snaked[:vegetable_types]
              .last[:peanut_names_and_spouses]
              .first[:bill_the_peanut]
            assert_equal "jillPeanut", @snaked[:vegetable_types]
              .last[:peanut_names_and_spouses]
              .last[:sammy_the_peanut]
          end
        end
      end
    end
  end

  describe "strings with spaces in them" do
    before do
      @hash = { "With Spaces" => "FooBar" }
      @snaked = @hash.to_snake_keys
    end

    it "doesn't get snaked, although it does get downcased" do
      assert @snaked.key?("with spaces")
    end
  end
end
