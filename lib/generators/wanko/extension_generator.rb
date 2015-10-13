require 'rails/generators/rails/plugin/plugin_generator'

module Wanko
  class ExtensionBuilder < ::Rails::PluginBuilder
    def readme() end
    def rakefile() end
  end

  module Generators
    class ExtensionGenerator < ::Rails::Generators::PluginGenerator
      source_root ::Rails::Generators::PluginGenerator.source_root

      class << self
        def source_paths
          [File.expand_path('../templates', __FILE__), *super]
        end
      end

      def initialize(*args)
        options = args.extract_options!
        options[:destination_root] = 'app/extensions'
        super(*args, options)
        options = @options.dup
        options[:mountable] = options[:skip_bundle] = options[:skip_test_unit] = options[:skip_git] = options[:skip_gemfile] = true
        @options = options.freeze
      end

      def get_builder_class
        Wanko::ExtensionBuilder
      end

      # override
      def create_bin_files
      end

      def put_litter_in_its_place
        remove_file 'MIT-LICENSE'
        remove_file "app/controllers/#{name}/application_controller.rb"
        remove_file "lib/tasks/#{name}_tasks.rake"
      end
    end
  end
end
