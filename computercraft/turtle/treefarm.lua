function waitForRedstonePulse()
    while true do
        -- Check if there is a redstone signal
        if rs.getInput("front") or rs.getInput("back") or rs.getInput("left") or rs.getInput("right") or rs.getInput("top") or rs.getInput("bottom") then
            return
        end
        
        -- Wait for a redstone change event
        os.pullEvent("redstone")
    end
end

function mineTree()
    -- Break the bottom block
    turtle.dig()
    turtle.forward()

    -- Dig straight up until we hit the top
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
    end

    -- Return to the bottom
    while not turtle.detectDown() do
        turtle.down()
    end
end

while true do
    -- Wait for a redstone pulse
    print("Waiting for redstone pulse")
    waitForRedstonePulse()
    print("Redstone pulse received")

    -- Refuel
    turtle.refuel()

    -- Mine trees until we encounter a chiseled stone brick block
    print("Going to mine some trees..")
    while true do
        -- Move to the next tree
        while turtle.forward() do end

        -- Check for chiseled stone bjrick
        local has_block, data = turtle.inspect()
        print(data)
        if has_block and data["name"] == "minecraft:stone_bricks" then break end

        -- Mine the tree
        mineTree()
    end

    -- Turn around
    turtle.turnLeft()
    turtle.turnLeft()
    print("Done!")
end
