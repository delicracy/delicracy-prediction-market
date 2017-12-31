module Mongoid
  module Document
    @@models = []

    def self.included base
      @@models << base
    end

    def self.models
      @@models
    end

    def as_json(options={})
      attrs = super(options)
      attrs['id'] = attrs['_id'].to_s
      attrs
    end

  end
end
