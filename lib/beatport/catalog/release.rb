module Beatport
    module Catalog
        class Release < Item
            has_many :artists, Artist
            has_one :audio_format_fee, AudioFormatFee
            has_many :genres, Genre
            has_one :images, Images
            has_one :label, Label
            has_one :price, Price
            has_one :recommendations, Recommendations
            has_many :tracks, Track
            has_one :tracks_price, Price

            def discount
                tracks_price - price
            end

            def self.find(*args)
                Client.retrieve 'releases', Release, *args
            end

            def self.all(options={})
                Client.retrieve 'releases', Release, options
            end

            def self.featured(*args)
                Client.retrieve 'featured/releases', Release, *args
            end

            def self.most_popular(id, options = {})
                options[:id] = id
                options[:collection] = true
                Client.retrieve "most-popular-releases", Release, options
            end

            def self.most_popular_for_genre(id, options = {})
                options[:id] = id
                options[:collection] = true
                Client.retrieve "most-popular-releases/genre", Release, options
            end

            def tracks(options = {})
                options[:release_id] = id
                Track.all(options)
            end
        end
    end
end
  