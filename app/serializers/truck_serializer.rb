class TruckSerializer
  include FastJsonapi::ObjectSerializer
  attributes :lat, :long, :name, :distance, :logo, :payment_methods, :website, :socials, :phone, :description, :display, :description_short
end
