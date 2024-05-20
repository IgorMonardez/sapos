# frozen_string_literal: true

class Affiliation < ApplicationRecord
  belongs_to :institution
  belongs_to :professor

  private
  def adjust_affiation
    all_professor = Versions.all.where(item_type: "Professor")
    all_professor.each do |v|
      Affiliation.new(institution: )
    end
  end

end
