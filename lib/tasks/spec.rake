if Rails.env.development? || Rails.env.test?
  require 'rspec/core/rake_task'

  namespace :spec do
    desc 'Generate JSON fixtures from various API specs'
    RSpec::Core::RakeTask.new(:generate_JSON_fixtures) do |t|
      t.rspec_opts = '--tag generate_fixture'
    end
  end
end