require 'redmine'

Rails.configuration.to_prepare do
  require_dependency 'journal'
  Journal.send(:include, RedmineMentions::JournalPatch)
end
Redmine::Plugin.register :redmine_mentions do
  name 'Redmine Mentions'
  author 'XSARUS, original by Arkhitech'
  description 'This is a plugin for Redmine which sends mail to mentioned users in comments.'
  version '0.0.2'
  url 'https://github.com/evs-xsarus/redmine_mentions'
  author_url 'http://www.xsarus.nl/'
  settings :default => {'trigger' => '@'}, :partial => 'settings/mention'
end
