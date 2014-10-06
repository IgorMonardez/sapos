class Report < ActiveRecord::Base
  belongs_to :query
  has_many :report_params, class_name: 'ReportParams', dependent: :destroy
  has_many :params, class_name: 'ReportParams', dependent: :destroy, conditions: {active: true}
  attr_accessible :description, :title
end
