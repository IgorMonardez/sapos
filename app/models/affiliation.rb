# frozen_string_literal: true

class Affiliation < ApplicationRecord
  belongs_to :institution
  belongs_to :professor

  private
  def adjust_affiation
    versions = PaperTrail::Version.where(item_type: "Professor")
    versions.where()
  end

end
