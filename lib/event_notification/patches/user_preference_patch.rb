module EventNotification
  module Patches
    module UserPreferencePatch

      def self.included(base) # :nodoc:
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable
        end
      end

      module ClassMethods
      end

      module InstanceMethods
        def ghost_mode; self[:ghost_mode] end
        def ghost_mode=(enabled); self[:ghost_mode]=enabled end

        def involved_in_related_notified; (self[:involved_in_related_notified] == true || self[:involved_in_related_notified] == '1'); end
        def involved_in_related_notified=(value); self[:involved_in_related_notified]=value; end

        def attachment_notification; (self[:attachment_notification] == true || self[:attachment_notification] == '1'); end
        def attachment_notification=(value); self[:attachment_notification]=value; end

        def relation_notification
          Setting.notified_events.include?("issue_updated") && (self[:relation_notification] == true || self[:relation_notification] == '1')
        end

        def relation_notification=(value); self[:relation_notification]=value; end
      end
    end
  end
end

unless UserPreference.included_modules.include? EventNotification::Patches::UserPreferencePatch
  UserPreference.send(:include, EventNotification::Patches::UserPreferencePatch)
end
