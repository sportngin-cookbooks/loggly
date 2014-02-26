require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  if installed(new_resource.tag)
    Chef::Log.info "#{ new_resource } already exists - nothing to do."
  else
    converge_by("Monitor #{ new_resource.tag } with loggly") do
      service 'rsyslog'
      template "/etc/rsyslog.d/22-loggly-#{new_resource.tag}.conf" do
        Chef::Log.info "Creating tempalte #{new_resource.tag}"
        source new_resource.source
        cookbook new_resource.cookbook
        variables(
          :path => new_resource.path,
          :tag => new_resource.tag,
          :token => new_resource.token,
          :severity => new_resource.severity,
          :port => new_resource.port
        )
        notifies :restart, "service[rsyslog]", :delayed
        new_resource.updated_by_last_action(true)
      end
    end
  end
end

action :delete do
  if installed(new_resource.tag)
    converge_by("Stop Monitoring #{ new_resource.tag } with loggly") do
      template "/etc/rsyslog.d/22-loggly-#{new_resource.tag}.conf" do
        action :delete
        source new_resource.source
        cookbook new_resource.cookbook
      end
    end
  else
    Chef::Log.info "#{ new_resource } does not exist - nothing to do."
  end
end

def installed(tag)
  cmd = Mixlib::ShellOut.new("ls /etc/rsyslog.d/22-loggly-#{tag}.conf")
  cmd.run_command
  Chef::Log.debug "#{tag}_conf_exists?: #{cmd.stdout}"
  begin
    cmd.error!
    true
  rescue
    false
  end
end
