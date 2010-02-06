Rails::Generator::Commands::Create.class_eval do
  def route_resource(*resources)
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    sentinel = 'ActionController::Routing::Routes.draw do |map|'

    logger.route "map.resource #{resource_list}"
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n  map.resource #{resource_list}\n"
      end
    end
  end
  
  def route_resources(*resources)
    resource_options = resources.last.is_a?(Hash) ? resources.pop : nil    
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    sentinel = 'ActionController::Routing::Routes.draw do |map|'

    resource_list << ", #{resource_options.inspect}" if resource_options
    logger.route "map.resources #{resource_list}"
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n  map.resources #{resource_list}\n"
      end
    end
  end
  
  def route_name(name, path, route_options = {})
    sentinel = 'ActionController::Routing::Routes.draw do |map|'
    
    routing_options = route_options.map { |k,v| ":#{k} => '#{v}'" }.join(', ')
    logger.route "map.#{name} '#{path}', #{routing_options}"
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n  map.#{name} '#{path}', #{routing_options}"
      end
    end
  end
end

Rails::Generator::Commands::Destroy.class_eval do
  def route_resource(*resources)
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    look_for = "\n  map.resource #{resource_list}\n"
    logger.route "map.resource #{resource_list}"
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{look_for})/mi, ''
    end
  end
  
  def route_name(name, path, route_options = {})
    look_for =   "\n  map.#{name} '#{path}', :controller => '#{route_options[:controller]}', :action => '#{route_options[:action]}'"
    logger.route "map.#{name} '#{path}',     :controller => '#{route_options[:controller]}', :action => '#{route_options[:action]}'"
    unless options[:pretend]
      gsub_file    'config/routes.rb', /(#{look_for})/mi, ''
    end
  end
end

Rails::Generator::Commands::List.class_eval do
  def route_resource(*resources)
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    logger.route "map.resource #{resource_list}"
  end
  
  def route_name(name, path, options = {})
    logger.route "map.#{name} '#{path}', :controller => '{options[:controller]}', :action => '#{options[:action]}'"
  end
end
