require "test_helper"
require "support/models"

class JSONMapperTest < Test::Unit::TestCase

  context "included in a model class" do

    setup do
      @klass = Class.new do
        include JSONMapper
        def to_s
          "TestUnitClass"
        end
      end
    end

    should "initialize empty attributes array" do
      @klass.attributes.should be []
    end

    should "allow adding a simple attribute mapping" do

      @klass.json_attribute :id, Integer

      @klass.attributes.size.should be 1
      @klass.attributes.first.name.should be :id
      @klass.attributes.first.source_attributes.should be [ :id ]
      @klass.attributes.first.type.should be Integer
      @klass.attributes.first.method_name.should be "id"

    end

    should "allow adding a complex attribute mapping" do
      @klass.json_attribute :id, [ :id, :attribute_id, :foo_id ], Integer
      @klass.attributes.size.should be 1
      @klass.attributes.first.name.should be :id
      @klass.attributes.first.source_attributes.should be [ :id, :attribute_id, :foo_id ]
      @klass.attributes.first.type.should be Integer
      @klass.attributes.first.method_name.should be "id"
    end

    should "parse simple json structure into a ruby object" do
      model = SimpleModel.parse(fixture_file("simple.json"))
      model.id.should be 1
      model.money.should be 125.50
      model.title.should be "Simple JSON title"
      model.boolean.should be true
      model.datetime.should be Date.parse("2010-10-08 17:59:46")
      model.date.should be Date.parse("2016-08-22 19:34:03")
      model.time.should be Time.parse("2016-08-23 19:56:47")
    end

    should "assign value from different sources into an attribute" do

      model = ComplexModel.parse('{ "id": 1 }')
      model.id.should be 1

      model = ComplexModel.parse('{ "attribute_id": 1 }')
      model.id.should be 1

    end

    should "not overwrite initial value when assigning values from different sources into an attribute" do

      model = ComplexModel.parse('{ "id": 1, "attribute_id": 2 }')
      model.id.should be 1

    end

    should "assign another model into an attribute" do

      model = ComplexModel.parse('{ "simple": { "id": 1 } }')
      model.simple.id.should be 1

    end

    should "assign an array into an attribute" do

      model = ComplexModel.parse('{ "integers": [ 1, 2, 3 ] }')
      model.integers.should be [ 1, 2, 3 ]

    end

    should "assign an array of models into an attribute" do

      model = ComplexModel.parse('{ "simples": [{ "id": 1 }, { "id": 2 }] }')
      model.simples.size.should be 2
      model.simples.first.id.should be 1
      model.simples.last.id.should be 2

    end

    should "parse complex json structure into a ruby object" do
      model = ComplexModel.parse(fixture_file("complex.json"))
      model.id.should be 1
      model.model_title.should be "Complex JSON title"
      model.simple.id.should be 1
      model.simple.title.should be "Simple JSON title"
      model.nested_test.should be "foo bar"
      model.simples.size.should be 2
      model.simples.first.id.should be 1
      model.simples.first.title.should be "Simple JSON title #1"
      model.simples.last.id.should be 2
      model.simples.last.title.should be "Simple JSON title #2"
    end

    should "be able to shift into a data structure to find the root element" do

      json = '{ "foo": { "id": 1 } }'
      model = SimpleModel.parse(json, :shift => :foo)
      model.id.should be 1

    end

    should "be able to shift deep into a data structure to find the root element" do

      json = '{ "foo": { "bar": { "id": 1 } } }'
      model = SimpleModel.parse(json, :shift => [ :foo, :bar ])
      model.id.should be 1

    end

    should "generate a collection of objects from an array" do

      json = '[ { "id": 1 }, { "id": 2 } ]'
      models = SimpleModel.parse_collection(json)
      models.size.should be 2

      models.first.id.should be 1
      models.last.id.should be 2

    end

    should "be able to use a delimited string as an array" do

      json = '{ "delimited": "foo,bar,baz" }'
      model = ComplexModel.parse(json)
      model.delimited.size.should be 3
      model.delimited[0].should be "foo"
      model.delimited[1].should be "bar"
      model.delimited[2].should be "baz"

    end

    should "be able to map an object to self" do

      json = '{ "id": 1 }'
      model = ComplexModel.parse(json)
      model.id.should be 1
      model.self_referential.id.should be 1

    end

    should "assign nil into an attribute when an array assign into an attribute (not attributes)" do

      json = '{ "simple": [{ "id" : 1 },{ "id" : 2 }] }'
      model = ComplexModel.parse(json)
      model.simple.id.should be nil

    end

    should "generate a model with empty value when parse an array json into a model" do

      json = '[{ "id" : 1 },{ "id" : 2 }]'
      model = ComplexModel.parse(json)
      model.id.should be nil
      model.simple.should be nil
      model.integers.should be []
      model.simples.should be []
      model.delimited.should be []

    end

    context "inheritance a super class attributes" do
      should "parse simple json structure into a ruby object" do
        model = SimpleChildModel.parse(fixture_file("simple.json"))
        model.simple_id.should be 1
        model.id.should be 1
        model.money.should be 125.50
        model.title.should be "Simple JSON title"
        model.boolean.should be true
        model.datetime.should be Date.parse("2010-10-08 17:59:46")
        model.date.should be Date.parse("2016-08-22 19:34:03")
        model.time.should be Time.parse("2016-08-23 19:56:47")
      end
    end

  end
end
