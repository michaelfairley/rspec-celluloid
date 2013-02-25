require 'rspec/celluloid/actor'

module RSpec
  module Celluloid
    class CommandLine
      def initialize(options, configuration=RSpec::configuration, world=RSpec::world)
        if Array === options
          options = ConfigurationOptions.new(options)
          options.parse_options
        end
        @options       = options
        @configuration = configuration
        @world         = world
      end

      # A modified form of RSpec::Core::CommandLine.run that runs the example groups in Celluloid actors
      def run(err, out)
        @configuration.error_stream = err
        @configuration.output_stream ||= out
        @options.configure(@configuration)
        @configuration.load_spec_files
        @world.announce_filters

        @configuration.reporter.report(@world.example_count, @configuration.randomize? ? @configuration.seed : nil) do |reporter|
          begin
            @configuration.run_hook(:before, :suite)
            @world.example_groups.ordered.map {|g| RSpec::Celluloid::Actor.pool.future.run(g,reporter)}.map {|f| f.value}.all? ? 0 : @configuration.failure_exit_code
          ensure
            @configuration.run_hook(:after, :suite)
          end
        end
      end
    end
  end
end
