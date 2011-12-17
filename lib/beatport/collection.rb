require 'forwardable'

module Beatport
  class Collection
    include Enumerable
    extend Forwardable
    
    def_delegators :@results, :each, :'<=>', :length, :==, :===, :to_a
    
    attr_reader :page, :per_page, :count, :spellcheck, :total_pages, :date_filters, :applied_date_filters, :facets, :applied_facets
    
    def initialize(klass, data)
      raise ArgumentError, "Invalid data passed to Collection.new" unless data['results'].is_a?(Array)
      
      data['metadata'].each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end
      
      @results = if klass == :auto
        data['results'].map do |r|
          item_klass = Inflector.constantize("Beatport::Catalog::#{r['type'].capitalize}")
          item_klass.new(r)
        end
      else
        data['results'].map { |r| klass.new(r) }
      end
    end
    
    def grouped
      group_by { |i| i.type.capitalize }
    end
    
  end
end