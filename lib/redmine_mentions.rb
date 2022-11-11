class MentionsLogFormatter < Logger::Formatter
  def call(severity, time, _progname, msg)
    "[%s] - %s - %s\n" % [severity, time.to_s(:short), msg2str(msg)] unless msg2str(msg).blank?
  end
end

MentionsLogger = Logger.new(Rails.root.join('log/redmine_mentions.log'))
MentionsLogger.formatter = MentionsLogFormatter.new

module RedmineMentions
end

REDMINE_MENTIONS_REQUIRED_FILES = [
  'redmine_mentions/patches/journal_patch'
]

base_url = File.dirname(__FILE__) + '/'

REDMINE_MENTIONS_REQUIRED_FILES.each { |file| require(base_url + file) }
