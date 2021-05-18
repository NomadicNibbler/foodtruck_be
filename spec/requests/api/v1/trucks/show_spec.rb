# it "when given a location it returns all the food trucks in the area" do
#   truck_id = 65830487
#   truck_data = FoodTruckService.get_truck_info(truck_id)
#
#   expect(truck_data.first).to be_a(Truck)
#   expect(truck_data.first[:id]).to eq(truck_id)
#   expect(truck_data.first[:lat]).to eq(1)
#   expect(truck_data.first[:long]).to eq(1)
#   expect(truck_data.first[:name]).to eq("some name")
#   expect(truck_data.first[:description]).to eq("super sick food truck")
#   expect(truck_data.first[:display]).to eq("4th and Icon st.")
#   expect(truck_data.first[:payment_methods]).to eq(['cash', 'applepay', 'credit'])
#   expect(truck_data.first[:logo_small]).to eq("some_name_logo_small.png")
# end
