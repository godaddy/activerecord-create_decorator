module ActiveRecord::ConnectionAdapters::SchemaStatementsExt
  def create_table(table_name, options={}, &block)
    create_options = ActiveRecord::Base.connection_config[:create_options]
    if create_options
      current_options = options[:options]
      if current_options
        options[:options] = "#{current_options} #{create_options}"
      else
        options[:options] = create_options
      end
    end

    super
  end
end

# bundle modified behavior with the SchemaStatements module
ActiveRecord::ConnectionAdapters::SchemaStatements.module_eval do

  # when SchemaStatements is included, add SchemaStatementsExt overrides
  def self.included(mod)
    mod.include ActiveRecord::ConnectionAdapters::SchemaStatementsExt 
  end

end

