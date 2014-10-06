# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.


module QueryFieldsHelpers

  extend ActiveSupport::Concern

  def code_mirror_view(id, type, value, set_size = false)
    set_size_str = set_size ? ".setSize(null, '#{value.count("\n") + 2}em')" : '';
    "<div id='#{id}'></div>
    <script>
    CodeMirror(document.getElementById('#{id}'),
     {mode: '#{type}',
      value: '#{escape_javascript(value)}',
      indentWithTabs: true,
      smartIndent: true,
      lineNumbers: true,
      matchBrackets : true,
      autofocus: true,
      readOnly: true
     }
    )#{set_size_str};
    </script>".html_safe
  end

  def query_sql_form_column(record, options)
    code_mirror_view("sql_query-view-#{record.id}", "text/x-mysql", (record.query.try(:sql) || ''), true)
  end

end