require 'action_controller/metal/responder'

module Responders
    module PublishResponder
        def to_format
            do_publish
            super
        end

        protected
            # REFACTOR: find a better way to detect whether this is a resource or collection?
            # REFACTOR: In the config, be able to map the resource and collection types to different methods.
            def do_publish
                type = @request.params[:id] ? 'resource' : 'collection'
                method = "publish_#{type}".to_sym
                Herald.publishers.each do |publisher|
                    data = type === 'resource' ? @resource : @resources
                    publisher.send(method, @controller.action_name, data) if publisher.respond_to? method
                end
            end
    end
end
