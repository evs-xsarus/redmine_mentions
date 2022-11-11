Redmine::Plugin.register :redmine_mentions do
  name 'Redmine Mentions'
  author 'XSARUS, original by Arkhitech'
  description 'This is a plugin for Redmine which sends mail to mentioned users in comments.'
  version '0.0.2'
  url 'https://github.com/evs-xsarus/redmine_mentions'
  author_url 'http://www.xsarus.nl/'
  settings :default => {'trigger' => '@'}, :partial => 'settings/mention'

  requires_redmine :version_or_higher => '5.0'
end

if Rails.configuration.respond_to?(:autoloader) && Rails.configuration.autoloader == :zeitwerk
  Rails.autoloaders.each { |loader| loader.ignore(File.dirname(__FILE__) + '/lib') }
end
require File.dirname(__FILE__) + '/lib/redmine_mentions'
