require 'itunes_search_api'

class SearchClient
    def self.main(artist)
        ITunesSearchAPI.search(
            :term    => artist,
            :country => "jp",
            :media   => 'music',
            :lang    => 'ja_jp',
            :limit  => '10'
            ).each do |item|
            p item
            print("#{item['artistName']},#{item['trackName']}\n")
        end
    end
end
