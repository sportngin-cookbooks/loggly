actions :create, :delete
default_action :create

attribute :tag, :kind_of => String, :required => true
attribute :cookbook, :kind_of => String, :default => "loggly"
attribute :path, :kind_of => String, :required => true
attribute :token, :kind_of => String, :required => true
attribute :severity, :kind_of => String, :default => "notice", :equal_to => %w(panic alert crit error warn notice info debug)
attribute :port,  :kind_of => Integer, :default => 514

attribute :source, :kind_of => String, :default => "loggly.conf.erb"


