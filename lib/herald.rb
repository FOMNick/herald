require 'rails/engine'
require 'herald/publish_responder'

module Herald
    @@publishers = []

    autoload :VERSION, 'herald/version'

    def self.publishers
        @@publishers
    end

    def self.publishers=(klasses)
        klasses = [ klasses ] unless klasses.is_a? Array
        klasses.each do |klass|
            klass = case klass
                when Class
                    klass
                when String, Symbol
                    ("#{klass.to_s.classify}Publisher").constantize
                else
                    raise "Publisher config must be a string, a symbol or a class."
                    end
            publisher = klass.new

            resource_method_exists = self.publish_method_exists? publisher, 'resource'
            collection_method_exists = self.publish_method_exists? publisher, 'collection'
            @@publishers << publisher if resource_method_exists || collection_method_exists
        end
    end

    protected
        def self.publish_method_exists?(publisher, method_suffix)
            method = "publish_#{method_suffix}"
            method_exists = publisher.respond_to? method
            Rails.logger.warn "WARNING: \"#{publisher.class}\" should implement a #{method} method if you wish to publish #{method_suffix.pluralize}." unless method_exists
            method_exists
        end
end
