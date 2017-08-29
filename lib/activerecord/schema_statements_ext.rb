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

# bundle modified behavior with the AbstractAdapter class
ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
  include ActiveRecord::ConnectionAdapters::SchemaStatementsExt
end

