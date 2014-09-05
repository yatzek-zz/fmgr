require 'timecop'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do

  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV['RAILS_ENV'] ||= 'test'

  puts "Rails env: #{ENV['RAILS_ENV']}"

  require 'rails/application'
  #Spork.trap_method(Rails::Application, :reload_routes!) # Rails 3.0
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!) # Rails 3.1+
  # Prevent main application to eager_load in the prefork block (do not load files in autoload_paths)
  Spork.trap_method(Rails::Application, :eager_load!)
  require File.expand_path('../../config/environment', __FILE__)
  # Load all railties files

  # TODO: fix this - commented out during migration to rails 4
  #Rails.application.railties.all { |r| r.eager_load! }


  require 'rspec/rails'
  require 'capybara/rails'
  require 'capybara/rspec'
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    #config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    # config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = :random

    # Include Factory Girl syntax to simplify calls to factories
    config.include FactoryGirl::Syntax::Methods

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.include MailerMacros
    config.before(:each){reset_email}

    # filter fun by :focus tag
    config.filter_run :focus => true
    # run all when no test with focus tag are found
    config.run_all_when_everything_filtered = true
    # enough to say: :focus rather than: :focus => true
    config.after(:each) do
      Timecop.return
    end

    config.raise_errors_for_deprecations!
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.
  FactoryGirl.reload

  # Hack to ensure models get reloaded by Spork - remove as soon as this is fixed in Spork.
  # Silence warnings to avoid all the 'warning: already initialized constant' messages that
  # appear for constants defined in the models.

  # Reload every run to capture changes
  Dir["#{Rails.root}/app/models/**/*.rb"].each {|f| load f}
  Dir["#{Rails.root}/app/controllers/**/*.rb"].each {|f| load f}
  Dir["#{Rails.root}/app/helpers/**/*.rb"].each {|f| load f}
  Dir["#{Rails.root}/app/mailers/**/*.rb"].each {|f| load f}

end