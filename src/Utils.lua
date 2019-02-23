-- AABB collision check
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

-- Keyboard input handler
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function generateQuads(textureName, tileWidth, tileHeight)
    local quads = {}
    local textureWidth, textureHeight = gTextures.tilesheet:getWidth(), gTextures.tilesheet:getHeight()
    for i = 1, textureHeight / tileHeight do
        table.insert(quads, {})
        for j = 1, textureWidth / tileWidth do
            table.insert(
                quads[i],
                love.graphics.newQuad((j - 1) * tileWidth, (i - 1) * tileHeight, 64, 64, textureWidth, textureHeight)
            )
        end
    end
    return quads
end