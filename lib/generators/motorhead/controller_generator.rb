require 'rails/generators/rails/controller/controller_generator'

module Motorhead
  module Generators
    class ControllerGenerator < ::Rails::Generators::ControllerGenerator
      source_root ::Rails::Generators::ControllerGenerator.source_root

      remove_hook_for :template_engine, :test_framework

      class << self
        def source_paths
          [File.expand_path('../templates', __FILE__), *super]
        end
      end

      # override
      def create_controller_files
        @destination_stack[@destination_stack.size - 1] = File.join @destination_stack.last, 'app/engines', class_path
        template 'controller.rb', File.join('app/controllers', class_path, "#{file_name}_controller.rb")
      end

      # override
      private
      def generate_routing_code(action)
        "get '#{file_name}/#{action}'"
      end
    end
  end
end
