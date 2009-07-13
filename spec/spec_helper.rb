$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'riddle'
require 'spec'
require 'spec/sphinx_helper'
Spec::Runner.configure do |config|
  sphinx = SphinxHelper.new
  sphinx.setup_mysql
  sphinx.generate_configuration
  sphinx.index
  
  config.before :suite do
    sphinx.start
    `php -f spec/fixtures/data_generator.php`
  end
  
  # config.before :each do
  #   sphinx.reset
  # end
  
  config.after :suite do
    sphinx.stop
  end
end

def query_contents(key)
  open("spec/fixtures/data/#{key.to_s}.bin") { |f| f.read }
end