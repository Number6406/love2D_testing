function love.load()
  N = 50
  M = 50
  scale=100
  mt = {}          -- create the matrix

  bornes = {
    xmin = 0,
    xmax = 50,
    ymin = 0,
    ymax = 50
  }

  renderMap()

  love.window.setMode(1200,600, {vsync=true});

  deep_water = love.graphics.newImage("1_.png")
  water = love.graphics.newImage("2_.png")
  sand = love.graphics.newImage("3_.png")
  land = love.graphics.newImage("4_.png")
  forest = love.graphics.newImage("5_.png")
  mountain = love.graphics.newImage("6_.png")
  peak = love.graphics.newImage("7_.png")

  tileset = {deep_water, water, water, sand, land, land, forest, forest, mountain, peak}
end

function renderMap()
  rand = love.timer.getTime()
  for i=0,N do
    mt[i] = {}     -- create a new row
    for j=0,M do
      mt[i][j] = (love.math.noise((i+math.floor(rand))/scale,j/scale))
    end
  end
end

function love.update(dt)
  renderMap()
end

function love.draw()
  drawMap(mt, 0.5, tileset, bornes)

  love.graphics.origin()
  love.graphics.setColor(255,255,255,255)
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function drawMap(relief, zoom, tileset, bornes)
  tilesW = tileset[1]:getWidth()*zoom
  tilesH = (tileset[1]:getHeight()-20)*zoom
  --love.graphics.translate(center[1]*tilesW/2,center[2]*tilesH/2);


  for y = bornes.ymin,bornes.ymax do
    for x = bornes.xmin,bornes.xmax do
      love.graphics.setColor(255,255,255,255)
      --love.graphics.setColor(255,255,255, relief[x][y]*255)
      love.graphics.draw(tileset[math.floor(relief[x][y]*10)+1], x*tilesW+(y*1/2*tilesW), 3/4*y*tilesH - (math.floor(relief[x][y]*100)*8), 0, zoom, zoom, tilesW/2, tilesH/2)

      --love.graphics.setColor(255,255,255,255)
      --love.graphics.print(x..";"..y,x*tilesW+(y*1/2*tilesW),3/4*y*tilesH)

      --pour des hexa plats
      --love.graphics.draw(tileset[math.floor(relief[x][y]*10)+1],(x+1/2*x)*tilesW+((y%2)*3/4*tilesH),(1/2*y)*tilesH,0,zoom)
      --love.graphics.print(x..";"..y,(x+1/3*x)*tilesW+((y%2)*tilesH)+20,(1/2*y)*tilesH+15)
    end
  end
end

function alternativeDraw()
  love.graphics.setBackgroundColor(255,255,255,255)

  for i = 0,N do
    for j = 0,M do
      love.graphics.setColor(255,255,255,255)
      --love.graphics.rectangle("fill", i*60, j*40, 60, 40)
      if(mt[i][j] <= 1) then
        love.graphics.draw(deep_water,(i+1/3*i)*60+((j%2)*40),(1/2*j)*40)
      elseif (mt[i][j] <= 3) then
        love.graphics.draw(water,(i+1/3*i)*60+((j%2)*40),(1/2*j)*40)
      elseif (mt[i][j] <= 5) then
        love.graphics.draw(sand,(i+1/3*i)*60+((j%2)*40),(1/2*j)*40)
      elseif (mt[i][j] <= 7) then
        love.graphics.draw(land,(i+1/3*i)*60+((j%2)*40),(1/2*j)*40)
      elseif (mt[i][j] <= 8) then
        love.graphics.draw(forest,(i+1/3*i)*60+((j%2)*40),(1/2*j)*40)
      elseif (mt[i][j] <= 9) then
        love.graphics.draw(mountain,(i+1/3*i)*60+((j%2)*40),(1/2*j)*40)
      else
        love.graphics.draw(peak,(i+1/3*i)*60+((j%2)*40),(1/2*j)*40)
      end
      love.graphics.print(i..";"..j,(i+1/3*i)*60+((j%2)*40)+20,(1/2*j)*40+15)
    end
  end

  love.graphics.setColor(0,0,0,255);

  for i = 0,N do
    love.graphics.line((i+1/3*i)*60,0,(i+1/3*i)*60,2000)
  end
  for j = 0,M do
    love.graphics.line(0,j*40,2000,j*40)
  end

end
