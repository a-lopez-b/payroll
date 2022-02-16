class ConceptTest < ActiveSupport::TestCase

    test "concept is not valid without a unique code" do
        concept = Concept.new(code: 1, name: "repeated", concept_type: 1, active:1)
        assert concept.invalid?
        assert_equal ["El codigo del concepto 1 debe de ser unico"], concept.errors[:code]
    end

end