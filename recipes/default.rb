# Cookbook Name:: loggly
# Recipe:: default
#
# Copyright (C) 2014 Sport Ngin
service 'rsyslog'

Chef::Log.info("Enabling Loggly for #{node[:loggly][:account]}")
template '/etc/rsyslog.d/22-loggly.conf' do
  source "base-loggly.conf.erb"
  variables(node[:loggly])
  notifies :restart, "service[rsyslog]", :delayed
end

node[:loggly][:files_to_monitor].each do |log_file|
  loggly_conf log_file[:tag] do
    path log_file[:path]
    tag log_file[:tag]
    severity log_file[:severity] || node[:loggly][:severity]
    port log_file[:port] || node[:loggly][:port]
    token node[:loggly][:token]
  end
end
