# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class ReportParamsController < ApplicationController
  authorize_resource

  active_scaffold 'report_params' do |config|


  end


end
