require("src/Dependencies")

function love.load()
    -- Keyboard input handler
    love.keyboard.keysPressed = {}

    gTextures = {
        ["tilesheet"] = love.graphics.newImage("assets/sokoban_tilesheet.png")
    }

    gFrames = generateQuads("tilesheet", 64, 64)
end

function love.draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.print("FPS: "..love.timer.getFPS())
    love.graphics.setColor(255, 255, 255)
end

function love.update(dt)
    -- Start debug with lovebird at http://127.0.0.1:8000/
    require("lib.lovebird").update()

    -- Reset keyboard input
    love.keyboard.keysPressed = {}

    -- Auto-swapping changed lua files
    require("lib/lurker").update()
end