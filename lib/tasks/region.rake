namespace :region do
  desc "TODO"
  task import: :environment do
    data = JSON.parse(File.read("data/regions.json"))

    # loop through cities
    data.each do |city_item|
      # check city not existed --> insert into database
      city = RegionData.check_and_insert_from_json(city_item, "Region::City")

      # loop through districts
      city_item[1]["quan-huyen"].each do |district_item|
        # check district not existed --> insert into database
        district = RegionData.check_and_insert_from_json(district_item, "Region::District", city.id)

        # loop through wards
        district_item[1]["xa-phuong"].each do |ward_item|
          # check district not existed --> insert into database
          RegionData.check_and_insert_from_json(ward_item, "Region::Ward", district.id)
        end
      end
    end

  end
end
