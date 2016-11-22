require "config"

SEED = math.random(love.timer.getTime())
XMIN = 0
YMIN = 0
XMAX = 200
YMAX = 200
TILE_SIZE = 20
SCALE = 20

--[[
Fonction de génération de map à partir d'une seed prédéfinie
]]
function generate(seed)

  SEED = math.floor(seed)

  -- set du seed commun
  love.math.setRandomSeed(SEED)
  -- Récupération de la valeur aléatoire initiale de génération de perlin
  mapSeed = love.math.random(10^9)

  map_matrix = {}
  for x=YMIN,XMAX do
    map_matrix[x] = {}     -- create a new row
    for y=YMIN,YMAX do
      map_matrix[x][y] = love.math.noise((x+mapSeed/10^5)/SCALE,(y+mapSeed%10^5)/SCALE)
    end
  end

  map = {
    relief = map_matrix,
    config = CONFIG
  }

  return map

end

--[[
Affiche une map de façon basique
]]
function printFlat(map, camera)


  xscreen = math.round(love.graphics.getWidth()/TILE_SIZE,0)
  yscreen = math.round(love.graphics.getHeight()/TILE_SIZE,0)

  if camera.x > XMAX then camera.x = XMAX elseif camera.x < XMIN then camera.x = XMIN end
  if camera.y > YMAX then camera.y = YMAX elseif camera.y < YMIN then camera.y = YMIN end

  print("CAMX : "..camera.x)

  xstart = math.ceil(camera.x - xscreen/2,0)
  if xstart < XMIN then xstart = XMIN
  elseif xstart > XMAX-xscreen then xstart = XMAX-xscreen end
  ystart = math.ceil(camera.y - yscreen/2,0)
  if ystart < YMIN then ystart = YMIN
  elseif ystart > YMAX-yscreen then ystart = YMAX-xscreen end

  print("Printing X : "..xstart.." : "..xstart+xscreen)

  mm = map.relief
  if map.config then
    CONFIG = map.config
  end

  for x = xstart, xstart+xscreen do
    for y = ystart, ystart+yscreen do
      drawSquare(mm, x, y)
    end
  end
  drawCamera(camera.x,camera.y, xstart, ystart)

  return camera
end

function drawSquare(relief, x, y)
  currentRelief = math.floor(relief[x][y] * table.getn(CONFIG.couches)) + 1
  currentColor = CONFIG.couches[currentRelief].couleur
  love.graphics.setColor(currentColor.r, currentColor.g, currentColor.b, currentColor.a)
  love.graphics.setLineWidth(CONFIG.border.size)
  love.graphics.rectangle("fill", (x-xstart)*TILE_SIZE, (y-ystart)*TILE_SIZE, TILE_SIZE, TILE_SIZE)
  love.graphics.setColor(CONFIG.border.color.r,CONFIG.border.color.g,CONFIG.border.color.b,CONFIG.border.color.a)
  love.graphics.rectangle("line", (x-xstart)*TILE_SIZE, (y-ystart)*TILE_SIZE, TILE_SIZE, TILE_SIZE)
end

function drawCamera(x, y)
  love.graphics.setColor(0, 255, 0, 200)
  love.graphics.rectangle("fill", (x-xstart)*TILE_SIZE, (y-ystart)*TILE_SIZE, TILE_SIZE, TILE_SIZE)
end

function showNoise(map)
  for x = 0, 500 do
    for y = 0, 500 do
      currentRelief = math.floor(map.relief[x][y] * 255)
      love.graphics.setColor(255,255,255,currentRelief)
      love.graphics.rectangle("fill", x, y, 1, 1)
    end
  end
end

function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end
