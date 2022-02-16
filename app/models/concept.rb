class Concept < ApplicationRecord
    validates :code, :name, :concept_type, :active, presence: {message:'%{attribute} es un campo obligatorio'}
    validates :code, uniqueness: {message:'El codigo del concepto %{value} debe de ser unico'}
    scope :available, -> { where('active:true') }

end
