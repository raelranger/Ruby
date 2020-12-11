#################################################################
# CARTOGRAPH OF ASEAN COVID 19 DATA
# developed in Ruby using ruby2d graphic library.
# (c) copyright 2020, Robert Batzinger. All rights reserved.
# Send inquiries to robert_b@payap.ac.th
#################################################################

require 'ruby2d'

class Country
  attr_accessor :name,  :active, :recover, :death, :population,
                :lat, :lng, :abbr, :area, :color, :mapobj, :maplbl, :mapnum,
                :dx, :dy

  def initialize(map,line)
    @name,  @active, @recover, @death, @population,
            @lat, @lng, @abbr, @area, @color = line.split(/,\s+/)
    @lat = @lat.to_f
    @lng = @lng.to_f
    @active = @active.to_f
    @recover = @recover.to_f
    @death = @death.to_f
    @population = @population.to_f
    @area = @area.to_f
    # Map marker and label that corresponds to the country object 
    @mapobj = Circle.new(x: @lng, y: @lat,  radius: 20, color: @color, z: 3)
    @mapobj.opacity = 0.5
    @maplbl = Text.new(@abbr, x: @lng -0.45, y: @lat+1, color: 'yellow',z:4)
    @mapnum = Text.new(@area, x: @lng -0.45, y: @lat+1, color: 'yellow',z:4)
    @dx = 0
    @dy = 0
  end

  # Returns the pixel position of the extreme edges
  def left
    return @mapobj.x - @mapobj.radius
  end

  def right
    return @mapobj.x + @mapobj.radius
  end

  def top
    return @mapobj.y - @mapobj.radius
  end

  def bottom
    return @mapobj.y + @mapobj.radius
  end

  def dist(cntryB)
    dx = @mapobj.x - cntryB.mapobj.x
    dy = @mapobj.y - cntryB.mapobj.y
    return Math.sqrt(dx*dx + dy*dy)
  end

  def mindist(cntryB)
    return @mapobj.radius + cntryB.mapobj.radius + 5
  end
  
  def overlap?(cntryB)
    return  mindist(cntryB) > dist(cntryB)
  end

  # Adjust the size of the marker depending of the cartograph
  def chgmap(maptype)
    case maptype
    when 'a' then @mapobj.radius = @active
    when 'b' then @mapobj.radius = (@recover+@death+@active)/@population
    when 'c' then @mapobj.radius = @active/@population
    when 'd' then @mapobj.radius = @death
    when 'e' then @mapobj.radius = 20.0
    when 'f' then @mapobj.radius = @recover/(@recover+@death+@active)
    when 'g' then @mapobj.radius = @death/@population
    when 'm' then @mapobj.radius = @death/(@recover+@death+@active)
    when 'o' then @mapobj.radius = Math.log(@population)
    when 'p' then @mapobj.radius = @population
    when 'l' then @mapobj.radius = @area
    end
  end

  # Update the position of country markers on the map
  def update
      @mapobj.x += @dx
      @mapobj.y += @dy

      @maplbl.x = @mapobj.x - 10
      @maplbl.y = @mapobj.y - 15

      @mapnum.x = @mapobj.x - 25
      @mapnum.y = @mapobj.y - -10

      chg = @dx.abs + @dy.abs
      @dy = @dx = 0
      return chg
  end    
end
#####################################
class Cartograph
  attr_accessor :screen, :y_max, :y_min, :x_max, :x_min,
                :y_scale, :x_scale, :x_range, :y_range,
                :left, :right, :top, :bottom, :cntrylist,
                :headline, :footline
  
  Cartograph::CHOICES = "abcdefgmopl"
  
  def initialize(screen,header,footer)
    @screen = screen
    @left = 50
    @right = @screen.width - @left
    @top = 50
    @headline = header
    @footline = footer
    @bottom = @screen.height - @top
    @cntrylist = Array.new
    end

  # Add a country to the master list
  def addcntry(line)
        @cntrylist << Country.new(@screen,line)
  end
  
  # Set up the bounding box and scale factors
  def resetbb
    @x_min = @x_max = @cntrylist[0].lng
    @y_min = @y_max = @cntrylist[0].lat
    @cntrylist.each do |cntry|
      @y_max = cntry.lat if cntry.lat > @y_max
      @y_min = cntry.lat if cntry.lat < @y_min

      @x_max = cntry.lng if cntry.lng > @x_max
      @x_min = cntry.lng if cntry.lng < @x_min
    end
    @x_range = @x_max - @x_min
    @y_range = @y_max - @y_min
    @x_scale = (@right - @left) / @x_range 
    @y_scale = (@bottom - @top) / @y_range
  end

  # Register a new map type specification
  def chgmap(maptype)
    @cntrylist.each do |cntry|
      cntry.chgmap(maptype)
    end
  end

  # Switch to the new map type
  def choosemap(maptype)
    case maptype
    when 'a' then @headline.text = "Active cases"
    when 'b' then @headline.text = "Morbidity"
    when 'c' then @headline.text = "Active cases/population"
    when 'd' then @headline.text = "Deaths"
    when 'e' then @headline.text = "Equally weighted Nations"
    when 'f' then @headline.text = "Percent cured"
    when 'g' then @headline.text = "Deaths / population"
    when 'm' then @headline.text = "Mortality rate/infected"
    when 'o' then @headline.text = "National Population (log)"
    when 'p' then @headline.text = "National Population"
    when 'l' then @headline.text = "Area of Countries"
    else  return
    end

    chgmap(maptype)
    replot
    resize
  end
  
  # Plot the points initially in the geolocation
  def replot
    @cntrylist.each do |cntry|
      cntry.mapobj.x = map_x(cntry.lng)
      cntry.mapobj.y = map_y(cntry.lat)
      cntry.maplbl.x = map_x(cntry.lng - 0.45)
      cntry.maplbl.y = map_y(cntry.lat + 1)
    end
  end

  # Expand the map to fill the screen
  def resize
    area = 0.0
    @cntrylist.each do |cntry|
      area += Math::PI * (cntry.mapobj.radius) * (cntry.mapobj.radius)
    end
    target = 0.60 *(@right - @left) * (@bottom - @top)
    scale = Math.sqrt(target / area)
    @cntrylist.each do |cntry|
      cntry.mapobj.radius *= scale
    end
  end

  #####################################################
  # Translate lattitude and longitude to graph position
  # requires inverting and scaling the values
  #
  # Lat -180 -90    0   90  180        0          Width
  #  90   +----+----+----+----+       0+-----+-----+
  #       .....................        |     |     |
  #   0   +----+----+----+----+  -->   +-----+-----+
  #       .....................        |     |     |
  # -90   +----+----+----+----+  Height+-----+-----+
  #          <- Longitude ->
  #
  #####################################################
  def map_x(lng)
    return 50 + (lng - @x_min) * @x_scale 
  end                           

  def map_y(lat)
    return  (@y_range - lat) * @y_scale
  end                           

  # Shift the markers to remove all overlaps
  def setmargins
    @cntrylist.each do |cntry|
      # Move country markers away from the borders
      if cntry.left < @left
        cntry.dx += (@left - cntry.left)/16
      elsif cntry.right > @right
          cntry.dx += (@right - cntry.right)/16
      end
      
      if cntry.top < @top
        cntry.dy += (@top - cntry.top)/16
      elsif cntry.bottom > @bottom
        cntry.dy +=  (@bottom - cntry.bottom)/16
      end
    end
  end
  
  def rmoverlap
    @cntrylist.size.times do |i|
      ((i+1)...@cntrylist.size).each do |j|
        if @cntrylist[i].overlap?(@cntrylist[j])
 
          ddx = @cntrylist[i].mapobj.x - @cntrylist[j].mapobj.x
          ddy = @cntrylist[i].mapobj.y - @cntrylist[j].mapobj.y
          ddh = Math.sqrt(ddx*ddx + ddy*ddy)
          dr  = (@cntrylist[i].mindist(@cntrylist[j]) -
                    @cntrylist[i].dist(@cntrylist[j])) / 3
          dddx = dr*ddx/ddh
          dddy = dr*ddy/ddh
          @cntrylist[i].dx += dddx
          @cntrylist[i].dy += dddy
          @cntrylist[j].dx -= dddx
          @cntrylist[j].dy -= dddy
=begin
          puts "#{@cntrylist[i].abbr} #{@cntrylist[j].abbr} dr #{dr} "
          puts "    ddx #{ddx} ddy #{ddy} ddh #{ddh}"
          puts "    dddx #{ddx*dr} dddy #{ddy*dr}"
=end
        end
      end
    end
  end

  def revise
    totalchg = 0.0
    @cntrylist.each do |cntry|
       totalchg += cntry.update
    end
    if totalchg < 0.01
      choosemap(Cartograph::CHOICES[rand(Cartograph::CHOICES.size)])
    end
  end
  
end

######################################################
# Application sequence

set title: "COVID19 Cartogram", background: 'navy',
    width: 800, height: 500

headline = Text.new("Equally weighted Nations", x: 350, y: 10,
                    size: 20, color: 'yellow', z: 10)

footline = Text.new("Commands: abcdefgmopx", x: 600, y: 480,
                    size: 14, color: 'yellow', z: 10)
  
screen = get :window

map = Cartograph.new(Window,headline,footline)

# Load in the dataset for ASEAN 
cntry = 0
DATA.each do |line|
  break if line =~ /END/
  map.addcntry(line.chomp) if (cntry > 0)
  cntry += 1
end

# Setup the map
map.resetbb
map.choosemap('e')


# Setup the keyboard event handlers
on :key_down do |event|
   close if event.key.eql?('x')
   map.choosemap(event.key)
   
end

# Animation loop to move countries into position
update do
    map.setmargins
    map.rmoverlap
    map.revise
end

# Start the graphics
show

__END__
Country, ActiveCases, Recovered, Deaths, Population, Lat,  Lng, Abbr,    Area, Color
Brunei,          2,        146,        3,      4.4,    5,  114,   BN,    5770,  teal
Cambodia,       40,        305,        0,      170,   13,  105,   KH,  181035,  maroon
Indonesia,   80023,     466178,    17479,     2750,   -5,  107,   ID, 1919440,  olive
Laos,           13,         26,        0,     73.0,   22,  104,   LA,  236800,  green
Malaysia,    10799,      59061,      376,      330,    3,  101,   MY,  329847,  orange
Myanmar,     19488,      74973,      797,      550,   22,   98,   MM,  676578,  red
Philippines, 28491,     399345,     8303,     1100,   13,  122,   PH,  299404,  aqua
Singapore,      61,      58152,       29,       58,    1,  103,   SG,     697,  lime
Taiwan,        111,        572,        7,      240,   24,  121,   TW,   36193,  purple
Thailand,      164,       3848,       60,      700,   15,  100,   TH,  513115,  brown
Vietnam,       106,       1220,       35,      980,   16,  107,   VN,  331690,  blue
END

Key:  As of 8/12/2020
Country - Short name of the country
ActiveCases - number of people currently sick
Recovered - number of patients that recovered
Deaths - number of COVID19 related deaths
Population - Population in Lakh (100K)
Lat - Approximate Lattitude of the country's geocenter
Lng - Approximate Longitude of the country's geocenter
Abbr - ISO3660 2 character code for the country
Color - Mapping color for this country
