require 'guard'
require 'guard/guard'
require 'cucumber'

module Guard

  # The Cucumber guard that gets notifications about the following
  # Guard events: `start`, `stop`, `reload`, `run_all` and `run_on_change`.
  #
  class Cucumber < Guard

    autoload :Runner, 'guard/cucumber/runner'
    autoload :Inspector, 'guard/cucumber/inspector'

    # Initialize Guard::Cucumber.
    #
    # @param [Array<Guard::Watcher>] watchers the watchers in the Guard block
    # @param [Hash] options the options for the Guard
    # @option options [String] :cli any arbitrary Cucumber CLI arguments
    # @option options [Boolean] :bundler use bundler or not
    # @option options [Array<String>] :rvm a list of rvm version to use for the test
    # @option options [Boolean] :notification show notifications
    # @option options [Boolean] :all_after_pass run all features after changed features pass
    # @option options [Boolean] :all_on_start run all the features at startup
    # @option options [Boolean] :keep_failed Keep failed features until they pass
    # @option options [Boolean] :run_all run override any option when running all specs
    # @option options [Boolean] :change_format use a different cucumber format when running individual features
    #
    def initialize(watchers = [], options = { })
      super
      @options = {
          :all_after_pass => true,
          :all_on_start   => true,
          :keep_failed    => true,
          :cli            => '--no-profile --color --format progress --strict'
      }.update(options)

      @last_failed  = false
      @failed_paths = []
    end

    # Gets called once when Guard starts.
    #
    # @raise [:task_has_failed] when stop has failed
    #
    def start
      run_all if @options[:all_on_start]
    end

    # Gets called when all specs should be run.
    #
    # @raise [:task_has_failed] when stop has failed
    #
    def run_all
      passed = Runner.run(['features'], options.merge(options[:run_all] || { }).merge(:message => 'Running all features'))

      if passed
        @failed_paths = []
      else
        @failed_paths = read_failed_features if @options[:keep_failed]
      end

      @last_failed = !passed

      throw :task_has_failed unless passed
    end

    # Gets called when the Guard should reload itself.
    #
    # @raise [:task_has_failed] when stop has failed
    #
    def reload
      @failed_paths = []
    end

    # Gets called when watched paths and files have changes.
    #
    # @param [Array<String>] paths the changed paths and files
    # @raise [:task_has_failed] when stop has failed
    #
    def run_on_change(paths)
      paths += @failed_paths if @options[:keep_failed]
      paths   = Inspector.clean(paths)
      options = @options[:change_format] ? change_format(@options[:change_format]) : @options
      passed  = Runner.run(paths, paths.include?('features') ? options.merge({ :message => 'Running all features' }) : options)

      if passed
        # clean failed paths memory
        @failed_paths -= paths if @options[:keep_failed]
        # run all the specs if the changed specs failed, like autotest
        run_all if @last_failed && @options[:all_after_pass]
      else
        # remember failed paths for the next change
        @failed_paths += read_failed_features if @options[:keep_failed]
        # track whether the changed feature failed for the next change
        @last_failed = true
      end

      throw :task_has_failed unless passed
    end

    private

    # Read the failed features that from `rerun.txt`
    #
    # @see Guard::Cucumber::NotificationFormatter#write_rerun_features
    # @return [Array<String>] the list of features
    #
    def read_failed_features
      failed = []

      if File.exist?('rerun.txt')
        failed = File.open('rerun.txt').read.split(' ')
        File.delete('rerun.txt')
      end

      failed
    end

    # Change the `--format` cli option.
    #
    # @param [String] format the new format
    # @return [Hash] the new options
    #
    def change_format(format)
      cli_parts = @options[:cli].split(" ")
      cli_parts.each_with_index do |part, index|
        if part == "--format" && cli_parts[index + 2] != "--out"
          cli_parts[index + 1] = format
        end
      end
      @options.merge(:cli => cli_parts.join(" "))
    end

  end
end
