---@class Level
Level = Class{}

local MAP = {
    ["wall"] = 0,
    ["floor"] = 1,
    ["box"] = 2,
    ["player"] = 3,
    ["goal"] = 4,
    ["completedGoal"] = 5
}

function Level:init(tileMap, playerR, playerC, numOfGoals)
    self._tileMap = tileMap
    
    self._tileMap[playerR][playerC] = 3
    self._player = Player(playerR, playerC, tileMap)

    self._numOfGoals = numOfGoals
end

function Level:render()
    for i = 1, #self._tileMap do
        for j = 1, #self._tileMap[i] do
            local x, y = (j - 1) * 64, (i - 1) * 64

            love.graphics.draw(gTextures.tilesheet, gFrames[7][12], x, y)

            if (self._tileMap[i][j] == MAP.wall) then
                love.graphics.draw(gTextures.tilesheet, gFrames[8][7], x, y)
            end
            if (self._tileMap[i][j] == MAP.box) then
                love.graphics.draw(gTextures.tilesheet, gFrames[1][7], x, y)
            end
            if (self._tileMap[i][j] == MAP.goal) then
                love.graphics.draw(gTextures.tilesheet, gFrames[2][13], x, y)
            end
            if (self._tileMap[i][j] == MAP.completedGoal) then
                love.graphics.draw(gTextures.tilesheet, gFrames[1][7], x, y)
            end
        end
    end

    self._player:render()
end

function Level:update(dt)
    self._player:update(dt)

    if (self._numOfGoals == 0) then
        love.event.quit()
    end
end