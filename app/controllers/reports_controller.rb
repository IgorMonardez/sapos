# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class ReportsController < ApplicationController
  authorize_resource

  active_scaffold 'report' do |config|


    form_columns = [:title, :description]
    config.list.columns = form_columns
    config.update.columns = [:title, :description, :query, :params]
    config.create.columns = [:title, :description, :query]
    config.show.columns = form_columns


    config.columns[:query].form_ui = :select
    config.columns[:query].update_columns = [:query, :params]

  end


end
