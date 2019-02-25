---@class Player
Player = Class {}

---@param level Level
function Player:init(row, column, level)
    self._row, self._column = row, column
    self:setPositions(row, column)

    self._level = level

    self._frames = {
        ["down"] = gFrames[5][1],
        ["up"] = gFrames[5][4],
        ["right"] = gFrames[7][1],
        ["left"] = gFrames[7][4]
    }
    self._facing = "down"

    self._highlighting = {
        row = 0,
        column = self._column,
        x = 0,
        y = 0
    }
    self:setHighlighting()

    self._carrying = false
    self._carried = {
        box = nil
    }
end

function Player:render()
    love.graphics.draw(gTextures.tilesheet, self._frames[self._facing], self._x, self._y)

    if
        (self._level._tileMap[self._highlighting.row][self._highlighting.column] == 1 or
            self._level._tileMap[self._highlighting.row][self._highlighting.column] == 4)
     then
        if (not self._carrying) then
            love.graphics.draw(gTextures.tilesheet, gFrames[4][1], self._highlighting.x, self._highlighting.y)
        else
            love.graphics.draw(gTextures.tilesheet, gFrames[4][2], self._highlighting.x, self._highlighting.y)
        end
    end
end

function Player:update(dt)
    self:movement()
    self:facing()

    if (love.keyboard.wasPressed("return")) then
        self:interact()
    end
end

function Player:movement()
    if (love.keyboard.wasPressed("right")) then
        if (self:isMovable(self._row, self._column + 1)) then
            self._level._tileMap[self._row][self._column] = 1
            self._column = self._column + 1
            self:setPositions()
            self._level._tileMap[self._row][self._column] = 3
            self._facing = "right"

            self:setHighlighting()
        end
    elseif (love.keyboard.wasPressed("left")) then
        if (self:isMovable(self._row, self._column - 1)) then
            self._level._tileMap[self._row][self._column] = 1
            self._column = self._column - 1
            self:setPositions()
            self._level._tileMap[self._row][self._column] = 3
            self._facing = "left"

            self:setHighlighting()
        end
    end

    if (love.keyboard.wasPressed("up")) then
        if (self:isMovable(self._row - 1, self._column)) then
            self._level._tileMap[self._row][self._column] = 1
            self._row = self._row - 1
            self:setPositions()
            self._level._tileMap[self._row][self._column] = 3
            self._facing = "up"

            self:setHighlighting()
        end
    elseif (love.keyboard.wasPressed("down")) then
        if (self:isMovable(self._row + 1, self._column)) then
            self._level._tileMap[self._row][self._column] = 1
            self._row = self._row + 1
            self:setPositions()
            self._level._tileMap[self._row][self._column] = 3
            self._facing = "down"

            self:setHighlighting()
        end
    end
end

function Player:facing()
    if (love.keyboard.wasPressed("w")) then
        self._facing = "up"
        self:setHighlighting()
    elseif (love.keyboard.wasPressed("s")) then
        self._facing = "down"
        self:setHighlighting()
    end
    if (love.keyboard.wasPressed("a")) then
        self._facing = "left"
        self:setHighlighting()
    elseif (love.keyboard.wasPressed("d")) then
        self._facing = "right"
        self:setHighlighting()
    end
end

function Player:isMovable(row, column)
    if (self._level._tileMap[row][column] == 1) then
        return true
    end
    return false
end

function Player:setPositions()
    self._x, self._y = (self._column - 1) * 64, (self._row - 1) * 64
end

function Player:setHighlighting()
    if (self._facing == "up") then
        self._highlighting.row = self._row - 1
        self._highlighting.column = self._column
    elseif (self._facing == "down") then
        self._highlighting.row = self._row + 1
        self._highlighting.column = self._column
    end
    if (self._facing == "left") then
        self._highlighting.column = self._column - 1
        self._highlighting.row = self._row
    elseif (self._facing == "right") then
        self._highlighting.column = self._column + 1
        self._highlighting.row = self._row
    end

    self._highlighting.x, self._highlighting.y = (self._highlighting.column - 1) * 64, (self._highlighting.row - 1) * 64
end

function Player:interact()
    if (not self._carrying) then
        -- If is box, pick it up
        if (self._level._tileMap[self._highlighting.row][self._highlighting.column] == 2) then
            self._level._tileMap[self._highlighting.row][self._highlighting.column] = 1
            self._carrying = true
        elseif (self._level._tileMap[self._highlighting.row][self._highlighting.column] == 5) then
            -- If is completed goal, pick box up and recalc goals
            self._level._tileMap[self._highlighting.row][self._highlighting.column] = 4
            self._carrying = true
            self._level._numOfGoals = self._level._numOfGoals + 1
        end
    else
        -- If is empty, put box down
        if (self._level._tileMap[self._highlighting.row][self._highlighting.column] == 1) then
            self._level._tileMap[self._highlighting.row][self._highlighting.column] = 2
            self._carrying = false
        end
        -- If is goal, complete it
        if (self._level._tileMap[self._highlighting.row][self._highlighting.column] == 4) then
            self._level._tileMap[self._highlighting.row][self._highlighting.column] = 5
            self._carrying = false
            self._level._numOfGoals = self._level._numOfGoals - 1
        end
    end
end
