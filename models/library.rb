
require 'geocoder/models/active_record'
class Library < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord

  def upload_file=(upload)
    title = upload[:title]
    filename = upload[:filename]
    #id = upload[:id]
    file = upload[:tempfile]
    
    File.open(file, "w") do |f|
      f.each_line do |line|
      end
    
      # img = Magick::ImageList.new "./public/img/#{filename}"
      # thumb = img.scale(0.1)
      # thumb.write "./public/thumbs/#{filename}"
    end
  end

  # def delete_file
  #   @library = Library.find_by({:id => params[:id]})
  #   filename = upload[:filename]
  #   File.delete("./public/img/#{filename}")
  #   File.delete("./public/thumbs/#{filename}")
  # end
end
