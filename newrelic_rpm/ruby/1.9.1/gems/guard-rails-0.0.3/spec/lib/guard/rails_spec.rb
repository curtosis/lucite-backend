require 'spec_helper'
require 'guard/rails'

describe Guard::Rails do
  let(:guard) { Guard::Rails.new(watchers, options) }
  let(:watchers) { [] }
  let(:options) { {} }

  describe '#initialize' do
    it "should initialize with options" do
      guard

      guard.runner.options[:port].should == 3000
    end
  end

  describe '#start' do
    let(:ui_expectation) { Guard::UI.expects(:info).with(regexp_matches(/#{Guard::Rails::DEFAULT_OPTIONS[:port]}/)) }

    context 'start on start' do
      it "should show the right message and run startup" do
        guard.expects(:run_all).once
        ui_expectation
        guard.start
      end
    end

    context 'no start on start' do
      let(:options) { { :start_on_start => false } }

      it "should show the right message and not run startup" do
        guard.expects(:run_all).never
        ui_expectation
        guard.start
      end
    end
  end

  describe '#run_all' do
    let(:pid) { '12345' }

    before do
      Guard::UI.expects(:info).with('Restarting Rails...')
      Guard::Notifier.expects(:notify).with(regexp_matches(/Rails restarting/), has_entry(:image => :pending))
      Guard::RailsRunner.any_instance.stubs(:pid).returns(pid)
    end

    let(:runner_stub) { Guard::RailsRunner.any_instance.stubs(:restart) }

    context 'with pid file' do
      before do
        runner_stub.returns(true)
      end

      it "should restart and show the pid file" do
        Guard::UI.expects(:info).with(regexp_matches(/#{pid}/))
        Guard::Notifier.expects(:notify).with(regexp_matches(/Rails restarted/), has_entry(:image => :success))

        guard.run_all
      end
    end

    context 'no pid file' do
      before do
        runner_stub.returns(false)
      end

      it "should restart and show the pid file" do
        Guard::UI.expects(:info).with(regexp_matches(/#{pid}/)).never
        Guard::UI.expects(:info).with(regexp_matches(/Rails NOT restarted/))
        Guard::Notifier.expects(:notify).with(regexp_matches(/Rails NOT restarted/), has_entry(:image => :failed))

        guard.run_all
      end
    end
  end
  
  describe '#stop' do
    it "should stop correctly" do
      Guard::Notifier.expects(:notify).with('Until next time...', anything)
      guard.stop
    end
  end

  describe '#run_on_change' do
    it "should run on change" do
      guard.expects(:run_all).once
      guard.run_on_change([])
    end
  end
end

