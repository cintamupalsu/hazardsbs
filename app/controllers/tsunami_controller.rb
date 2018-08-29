class TsunamiController < ApplicationController
  def index
  end

  def map
    #sample parameters http://hazard-maulanamania.c9users.io/tsunami/map?coord=34.651204_137.773077_640_640_jpg_16_test_1
    parastr = params[:coord]

    #breakdown parametes >>>
    dline= parastr.split('_')
    lat=dline[0].to_f
    lon=dline[1].to_f
    map_width=dline[2].to_i
    map_height=dline[3].to_i
    map_format=dline[4].to_s
    map_scale=dline[5].to_i
    map_type=dline[7].to_i
    username=dline[6]
    #breakdown parametes <<<
    
    rectangle_map = gen_rectangle_map(lat, lon, map_width, map_height, map_format, map_scale, map_type, username)
    panorama = gen_panorama(parastr)
    render :json=>{map: rectangle_map, view: panorama}
  end
  
  def gen_rectangle_map(lat, lon, map_width, map_height, map_format, map_scale, map_type, username)
    
    @guest = Guest.new
    @guest.lat=lat
    @guest.lon=lon
    @guest.identity=username
    
    fileRescue=true
    begin
      open("map"+username+"."+map_format, 'wb') do |file|
        sampleFile="https://maps.googleapis.com/maps/api/streetview?size=640x640&location=34.74894,137.760163&heading=145&pitch=15&&fov=65"
        file << open(sampleFile).read
        @guest.picture = file
      end
    rescue
       fileRescue=false
    end
    
    if @guest.save && fileRescue==true 
      staticmap = "https://sbs-maulanamania.c9users.io"+@guest.picture.url
    else
      staticmap = "http://hazard-maulanamania.c9users.io/picture/paraerror.jpg"
    end

  end
  
  def gen_panorama(parastr)
    if parastr==nil
      return staticmap = "http://hazard-maulanamania.c9users.io/picture/paraerror.jpg"
    end
  end
  
end
