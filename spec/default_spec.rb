require_relative 'spec_helper'

describe 'loggly::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:loggly][:account] = 'test'
      node.set[:loggly][:token] = 'super-secret-token'
      node.set[:loggly][:files_to_monitor] = [
        { tag: 'test1', path: 'path/to/test1' },
        { tag: 'test2', path: 'path/to/test2' }
      ]
    end.converge(described_recipe)
  end

  context "base-template" do
    it "creates the loggly-base template" do
      expect(chef_run).to render_file("/etc/rsyslog.d/22-loggly.conf")
    end

    it "notifies rsyslog that it needs to restart" do
      base_template = chef_run.template("/etc/rsyslog.d/22-loggly.conf")
      expect(base_template).to notify("service[rsyslog]").to(:restart)
    end
  end

  context "files_to_monitor" do
    it "creates a loggly_conf for every entry in files_to_monitor" do

      expect(chef_run).to create_loggly_conf('test1')
      expect(chef_run).to create_loggly_conf('test2')
    end
  end
end
