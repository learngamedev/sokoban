require("src/Dependencies")

function love.load()
    -- Keyboard input handler
    love.keyboard.keysPressed = {}
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
end