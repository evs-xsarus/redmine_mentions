module RedmineMentions
  module Patches
    module JournalPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
          after_create :send_mail
        end
      end

      module InstanceMethods
        def send_mail
          # MentionsLogger.try(:error, "gelukt")
          if self.journalized.is_a?(Issue) && self.notes.present?
            # MentionsLogger.try(:error, "mogen verder")
            issue = self.journalized
            project=self.journalized.project
            users=project.users.to_a.delete_if{|u| (u.type != 'User' || u.mail.empty?)}
            users_regex=users.collect{|u| "#{Setting.plugin_redmine_mentions['trigger']}#{u.login}"}.join('|')
            regex_for_email = '\B('+users_regex+')\b'
            regex = Regexp.new(regex_for_email)
            mentioned_users = self.notes.scan(regex)
            mentioned_users.each do |mentioned_user|
              username = mentioned_user.first[1..-1]
              if user = User.find_by_login(username)
                # MentionsLogger.try(:error, "mag mailen")
                MentionMailer.notify_mentioning(issue, self, user).deliver
              end
            end
          end
        end
      end
    end
  end
end

unless Journal.included_modules.include?(RedmineMentions::Patches::JournalPatch)
  Journal.send(:include, RedmineMentions::Patches::JournalPatch)
end