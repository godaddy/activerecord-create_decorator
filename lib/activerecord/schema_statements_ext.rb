ActiveRecord.module_eval do
  ActiveRecord::ConnectionAdapters.module_eval do
    ActiveRecord::ConnectionAdapters::SchemaStatements.module_eval do
      def create_table_with_options_decoration(table_name, options={}, &block)
        create_options = ActiveRecord::Base.connection_config[:create_options]
        if create_options
          current_options = options[:options]
          if current_options
            options[:options] = "#{current_options} #{create_options}"
          else
            options[:options] = create_options
          end
        end

        if block_given?
          create_table_without_options_decoration(table_name, options, &block)
        else
          create_table_without_options_decoration(table_name, options)
        end
      end

      alias_method_chain :create_table, :options_decoration
    end
  end
end