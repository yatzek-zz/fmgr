#Slim::Engine.set_default_options pretty: Rails.env.development?
#Slim::Engine.set_default_options pretty: true, sort_attrs: false
#Slim::Engine.set_default_options :shortcut => {'c' => {:tag => 'container'}, '#' => {:attr => 'id'}, '.' => {:attr => 'class'} }
#Slim::Engine.set_default_options :shortcut => {'&' => {:tag => 'input', :attr => 'type'}, '#' => {:attr => 'id'}, '.' => {:attr => 'class'}}
Slim::Engine.default_options[:pretty] = true