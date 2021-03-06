FactoryGirl.define do
  factory :site do
    title             "Capitol"
    description       "Atlanta's capitol building"
    image_file_name   "site_photo.jpg"
    audio_file_name   "my_narration.mp3"
    latitude          "12.23232323"
    longitude         "34.34343434"
    street            "1212 Latham Drive"
    city              "Atlanta"
    state             "Georgia"
    zip               30315 
    country           "USA"
    tour

    after(:create) do |site|
        create(:rating, rateable: site)
      end
      
    factory :site_with_ratings do
      transient do
        site_rating_count 5
      end
      after(:create) do |site, evaluator|
        create_list(:site_rating, evaluator.site_rating_count, site: site)
      end
    end
  end
end
