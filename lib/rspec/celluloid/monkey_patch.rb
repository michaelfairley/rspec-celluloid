require 'rspec/core'
require 'rspec/celluloid/command_line'

RSpec::Core::Runner.class_eval do
  def self.run(args, err=$stderr, out=$stdout)
    trap_interrupt
    options = RSpec::Core::ConfigurationOptions.new(args)
    options.parse_options

    if options.options[:drb]
      raise "Can't use the drb option with rspec-celluloid"
    else
      RSpec::Celluloid::CommandLine.new(options).run(err, out)
    end
  ensure
    RSpec.reset
  end
end

RSpec::Core::Configuration.class_eval do
  def files_or_directories_to_run=(*files)
    files = files.flatten
    files << default_path if (command == 'crspec' || Runner.running_in_drb?) && default_path && files.empty?
    self.files_to_run = get_files_to_run(files)
  end
end
