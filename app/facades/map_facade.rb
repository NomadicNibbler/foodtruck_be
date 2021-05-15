class MapFacade
  def self.get_coords(address)
    MapService.get_coords(address)
  end
end
