json.sites @sites do |site|
  json.extract! site, :id, :tour_id, :title, :description, :image_file_name, 
                      :audio_file_name, :lat, :lon
end