if defined?(ChefSpec)
  def create_loggly_conf(tag)
    ChefSpec::Matchers::ResourceMatcher.new(:loggly_conf, :create, tag)
  end

  def delete_loggly_conf(tag)
    ChefSpec::Matchers::ResourceMatcher.new(:loggly_conf, :delete, tag)
  end
end
