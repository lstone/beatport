require 'spec_helper'

module Beatport::Catalog
  describe Home do
    describe '.get' do
      subject { Home.get }
        
      its (:'slideshow.header.length') { should be >= 1 }
      its (:'slideshow.feature.length') { should be > 1 }
      its (:'features.length') { should be > 1 }
      its (:'top_downloads.length') { should be > 1 }
    end
  end
end