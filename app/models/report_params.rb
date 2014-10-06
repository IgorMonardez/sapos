class ReportParams < ActiveRecord::Base
  belongs_to :report
  belongs_to :query_param
  attr_accessible :editable, :value
end
