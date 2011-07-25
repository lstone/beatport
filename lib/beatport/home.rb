module Beatport
  class Home < Item
    has_one :slideshow, Slideshow
    has_many :features, Feature
    has_many :topDownloads, Track
    
    def self.get
      Client.retrieve 'home', Home
    end
  end
end