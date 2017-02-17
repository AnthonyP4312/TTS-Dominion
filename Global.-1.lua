DISABLE_SCRIPT = false
Supply = {}
cleanup = {}
TurnColor = ""
cardPlayed = {}
errorTable = {}
TREASURE = 0
ACTION = 1
BUY = 1
supplyKey = 0
trashedFlag = 0
TRFlag = 0
TRstack = 0
FeastFlag = 0
WSFlag = 0
MineFlag = 0
RemodelFlag = 0
MLFlag = 0
supplySize = 0
gameOverFlag = false
carryDoneFlag = true
scoreTable = {}
waitStack = 0
carryDraw = 0
AdFlag = 0
revCount = 0
cloneDone = true

--positions for Reveals
--Color = X , Z , +X, +Z, newRowX, newRowZ
revPosTable = {

    White = {23, -1, -1, 0, 0, -2.5},
	Red = {-23, -1, 1, 0, 0, -2.5},
	Purple = {10, -9, 0, 1, 2.5, 0},
	Orange = {-10, 9, 0, -1, -2.5, 0},
	Green = {-23, 1, 1, 0, 0, 2.5},
	Blue = {23, 1, -1, 0, 0, 2.5}

}




genericCardEvent = [[
function onPickedUp(player_color)
    if player_color == Global.getVar("TurnColor") then
        initCardPos = self.getPosition()
        if (math.abs(initCardPos.x) < 7) and (math.abs(initCardPos.z) < 8) then
            if (initCardPos.x > 3 and initCardPos.x < 5) and (initCardPos.z > -0.45 and initCardPos.z < 2.7) then
                return
            end
            Global.call("buyCard", {self.getName(), self.getGUID(), self})
		elseif (math.abs(initCardPos.x) < 26) and (math.abs(initCardPos.z) < 16) then
            badFlag = true
		else
			badFlag = false
        end
    end
end

function onDropped(player_color)
    if player_color == Global.getVar("TurnColor") then
        finalCardPos = self.getPosition()
        if (math.abs(finalCardPos.x) < 7) and (math.abs(finalCardPos.z) < 8) then
            if (finalCardPos.x > 3 and finalCardPos.x < 5) and (finalCardPos.z > -0.45 and finalCardPos.z < 2.7) then
                Global.call("trashCard", {self.getName(), self.getGUID(), self, player_color})
            end
            return
        end
        if math.abs(finalCardPos.x) < 26 and math.abs(finalCardPos.z) < 16 and badFlag == false then
            Global.call("playCard", {self.getName(), self.getGUID(), self})
        end
    end
end]]

--moat detection table
moatTable = {

    White = false,
	Red = false,
	Purple = false,
	Orange = false,
	Green = false,
	Blue = false

}

mult = {
    White = 1.3,
    Red = 1.5,
    Purple = 1.3,
    Orange = 1.3,
    Green = 1.3,
    Blue = 1.5
}


--coin model
custom = {}
custom.mesh = "http://pastebin.com/raw.php?i=duw0CPpJ"
custom.diffuse = "http://i.imgur.com/o1x5jVR.png"
custom.normal = "http://i.imgur.com/o1x5jVR.png"
custom.type = 3
custom.material = 2
custom.specular_intensity = 0.9
custom.specular_color = {0.7,0.7,0.7}
custom.specular_sharpness = 7.0


--PlayerZone GUIDs
--Deck / Hand / Discard / drawPos Table
zoneGUIDs = {

    White = {"fd649f","1050a1","acccd2" , {9.68,5,-20}},
    Red = {"b836df", "5a1ead", "8e2c6d", {-20,5,-20}},
    Purple = {"c47fbe", "72bbf0", "9b8aba", {30,5,-7.5}},
    Orange = {"0cd739", "f045a5", "6e5034", {-30,5,7.5}},
    Green = {"433bf4", "9aae2c", "417377", {-9,5,20}},
    Blue = {"2011d3", "810a8f", "e91b4d", {21,5,20}}

}

--Counter GUIDs
--Color = Treasure / Action / Buy
playerStats = {

	White = {"a2ec10","bf458c","a88834"},
	Red = {"dc7723", "fc7483", "7afcf0"},
	Purple = {"1b1df1", "35a2d3", "a0362c"},
	Orange = {"971d35", "7ba1a9", "cf602d"},
	Green = {"b193d6", "733690", "7d41f8"},
	Blue = {"a3452d", "ac3d09", "24f082"}

}

playZoneGUID = "a00107"
supplyGUID = "4fa2b0"
trashGUID = "9c4159"
silverGUID = "f90ef7"
curseGUID = "8a493f"
startButtonGUID = "727054"
setupOnlyButtonGUID = "df1ee1"
provGUID = "06145e"

--x,z of the supply positions
--GUID = Cop/Sil/Gold/Est/Duc/Prov/Curse
SupplyPos = {
	x = {-1.64, 0.1, 1.8, -1.64, 0.1, 1.8, 0.1, -3.4, -1.64, 0.1, 1.8, 3.5, -3.4, -1.64, 0.1, 1.8, 3.5},
	z = {0, 0, 0, 2.5, 2.5, 2.5, 5.2, -2.7, -2.7, -2.7, -2.7, -2.7, -5.3, -5.3, -5.3, -5.3, -5.3},
	GUID = {"edfaea", "82b2b0", "693427", "d49dfe", "34e870", "a76382", "79f9ab"}
}

--Name = Cost / Treasure / Buy / Action / Card / Function
Default = {

	Copper = {0,1,0,-1,0,0},
	Silver = {3,2,0,-1,0,0},
	Gold = {6,3,0,-1,0,0},
	Platinum = {9,5,0,-1,0,0},
	Estate = {2,0,0,-1,0,0},
	Duchy = {5,0,0,-1,0,0},
	Province = {8,0,0,-1,0,0},
	Colony = {12,0,0,-1,0,0},
	Curse = {0,0,0,-1,0,0},

}

VictoryTable = {

	Estate = 1,
	Duchy = 3,
	Province = 6,
	Colony = 10,
	Curse = -1,
	Gardens = 0

}

--Name = Cost / Treasure / Buy / Action / Card / Function
Base = {

	Adventurer = {6,0,0,0,0,1},
	Bureaucrat = {4,0,0,0,0,1},
	Cellar = {2,0,0,1,0,1},
	Chancellor = {3,2,0,0,0,1},
	Chapel = {2,0,0,0,0,1},
	Council_Room = {5,0,1,0,4,1},
	Feast = {4,0,0,0,0,1},
	Festival = {5,2,1,2,0,0},
	Gardens = {4,0,0,-1,0,0},
	Laboratory = {5,0,0,1,2,0},
	Library = {5,0,0,0,0,1},
	Market = {5,1,1,1,1,0},
	Mine = {5,0,0,0,0,1},
	Militia = {4,2,0,0,0,1},
	Moat = {2,0,0,0,2,0},
	Moneylender = {4,0,0,0,0,1},
	Remodel = {4,0,0,0,0,1},
	Smithy = {4,0,0,0,3,0},
	Spy = {4,0,0,1,1,1},
	Thief = {4,0,0,0,0,1},
	Throne_Room = {4,0,0,0,0,1},
	Witch = {5,0,0,0,2,1},
	Woodcutter = {3,2,1,0,0,0},
	Workshop = {3,0,0,0,0,1},
	Village = {3,0,0,2,1,0}

}

function onload()
end

function setupOnly()
    DISABLE_SCRIPT = true
    trashGUID = ""
    genericCardEvent = ""
end

function onPlayerTurnEnd(player_color)
    if DISABLE_SCRIPT == true then
        return
    end

	getObjectFromGUID(playerStats[TurnColor][2]).Counter.clear()
	getObjectFromGUID(playerStats[TurnColor][3]).Counter.clear()
    resetFlags()
    moatTableReset()
	deleteCoins(#cleanup)
    getObjectFromGUID(playerStats[TurnColor][1]).Counter.clear()
	emptyHand(player_color)
	cleanup = {}
	cardPlayed = {}
    if checkEnd() == true then
        startLuaCoroutine(Global, "takeDiscardEND")
        gameOverFlag = true
        printToAll("Calculating Scores...", {0.2,1,0.2})
        return
    end
    lastTurnColor = player_color
    carryDraw = 0
    startLuaCoroutine(Global, "delayDraw")
end

function delayDraw(color)
    for i=1,15 do
        coroutine.yield(0)
    end

    drawCard(5, lastTurnColor)
    return 1
end

function onPlayerTurnStart(player_color)
    if DISABLE_SCRIPT == true then
        return
    end
    if gameOverFlag == true then
        return
    end
	Global.setVar("TurnColor", player_color)
    TurnColor = player_color
	TurnPlayer = getPlayer(player_color)
    playerList = getSeatedPlayers()
	getObjectFromGUID(playerStats[TurnColor][2]).Counter.increment()
	getObjectFromGUID(playerStats[TurnColor][3]).Counter.increment()
end

--function onObjectEnterScriptingZone(zone, object) --Objects entering scripting zones
	--if zone.getGUID() == trashGUID then --Trashed card
	--end
--end

function trashCard(cardName)
    if cardName[4] ~= TurnColor then
        return
    end
    if MineFlag > 0 then
        trashedFlag = trashedFlag + 1
        trashValue = Supply[cardName[1]][1]
    elseif MLFlag > 0 then
        if cardName[1] == "Copper" then
            TREASURE = 3
            startLuaCoroutine(Global, "spawnCoins")
        end
        MLFlag = MLFlag - 1
    elseif FeastFlag > 0 then
        if cardName[1] == "Feast" then
            trashedFlag = trashedFlag + 1
            for k,v in pairs(cardPlayed) do
                if getObjectFromGUID(v).getName() == "Feast" then
                    table.remove(cardPlayed, k)
                end
            end
        end
    elseif RemodelFlag > 0 then
        trashedFlag = trashedFlag + 1
        trashValue = Supply[cardName[1]][1]
    else
        return
    end
end

function buyCard(cardName)
	local cardValue = Supply[cardName[1]][1]

    for k,v in pairs(cardPlayed) do
		if v == cardName[2] then
			return
		end
	end

	if FeastFlag > 0 and trashedFlag > 0 then
        cardValue = cardValue - 5
        if cardValue > 0 then
            printToColor("Card is too expensive.", TurnColor, {1,0,0})
            return
        else
            FeastFlag = FeastFlag - 1
            trashedFlag = trashedFlag - 1
        end
        goto bypass
	elseif WSFlag > 0 then
        cardValue = cardValue - 4
        if cardValue > 0 then
            printToColor("Card is too expensive.", TurnColor, {1,0,0})
            return
        else
            WSFlag = WSFlag - 1
            goto bypass
        end
    elseif MineFlag > 0 and trashedFlag > 0 then
        if cardName[1] == "Copper" or cardName[1] == "Silver" or cardName[1] == "Gold" or cardName[1] == "Platinum" then
            cardValue = cardValue - (trashValue + 3)
            if cardValue > 0 then
                printToColor("Card is too expensive.", TurnColor, {1,0,0})
                return
            else
                MineFlag = MineFlag - 1
                trashedFlag = trashedFlag - 1
                return
            end
        else
            printToColor("The Mine can only exchange treasure cards", TurnColor, {1,0,0})
            return
        end
    elseif RemodelFlag > 0 and trashedFlag > 0 then
        cardValue = cardValue - (trashValue + 2)
        if cardValue > 0 then
            printToColor("Card is too expensive.", TurnColor, {1,0,0})
            return
        else
            RemodelFlag = RemodelFlag - 1
            trashedFlag = trashedFlag - 1
            goto bypass
        end

	end
	if cardValue > getTRE(TurnColor) then
		printToAll(TurnColor .. " can't afford that!",  {1,0,0})
		return
	end
	if getBUY(TurnColor) < 1 then
		printToAll(TurnColor .. " doesn't have enough Buys!",  {1,0,0})
		return
	end
	getObjectFromGUID(playerStats[TurnColor][2]).Counter.decrement()
    ::bypass::
	addCard(cardName[2])
	deleteCoins(cardValue)
end

function playCard(cardName)
	cardTable = Supply[cardName[1]]
	for k,v in pairs(cardPlayed) do
		if v == cardName[2] then
			return
		end
	end
	if TRFlag > 0 and cardTable[4] > -1 then --Throne Room Flag
        if cardName[1] == "Throne_Room" then
            TRstack = TRstack + 1
            addCard(cardName[2])
            return
        end
        if cardName[1] == "Adventurer" then
            AdFlag = 4
            addCard(cardName[2])
            startLuaCoroutine(Global, "CoAdventurer")
            TRFlag = 0
            return
        end
        if cardName[1] == "Spy" then
            revCount = 2
            addCard(cardName[2])
            ACTION = 2
        	setACT(ACTION, TurnColor)
            drawCard(2, TurnColor)
            startLuaCoroutine(Global, "CoSpy")
            TRFlag = 0
            return
        end
        if cardName[1] == "Thief" then
            revCount = 4
            addCard(cardName[2])
            startLuaCoroutine(Global, "CoThief")
            TRFlag = 0
            return
        end
        if cardTable[5] > 0 then
            drawCard(cardTable[5]*TRFlag, TurnColor)
            TRFlag = TRFlag - 1
            goto resetTR
        end
        TRFlag = TRFlag - 1
        goto resetTR
	end
	if cardTable[4] > -1 then
		if getACT(TurnColor) < 1 then
			printToColor("You don't have any more Actions.", TurnColor,  {1,0,0})
			return
		end
		getObjectFromGUID(playerStats[TurnColor][3]).Counter.decrement()
	end
    drawCard(cardTable[5], TurnColor)   --draw cards
    ::resetTR::
	addCard(cardName[2])				--allocate stats
	TREASURE = cardTable[2]
	startLuaCoroutine(Global, "spawnCoins")
	BUY = cardTable[3]
	setBUY(BUY, TurnColor)
	ACTION = cardTable[4]
	setACT(ACTION, TurnColor)
    if TRFlag > 0 and cardName[1] ~= "Throne_Room" and cardTable[4] > -1 then --Throne Room Flag
        TRFlag = TRFlag - 1
        TRCardName = cardName[1]
        startLuaCoroutine(Global, "CoTR")
        goto resetTR
	end
	if cardTable[6] == 1 then --call specific card function
		Global.call(cardName[1])
	end
    if TRstack > 0 then
        TRstack = TRstack - 1
        TRFlag = TRFlag + 2
        return
    end
end

function setBUY(num)
	for _ =1,num do
		getObjectFromGUID(playerStats[TurnColor][2]).Counter.increment()
	end
end

function setACT(num)
	for _ =1,num do
		getObjectFromGUID(playerStats[TurnColor][3]).Counter.increment()
	end
end

function getBUY(color)
	return getObjectFromGUID(playerStats[color][2]).Counter.getValue()
end

function getACT(color)
	return getObjectFromGUID(playerStats[color][3]).Counter.getValue()
end

function getTRE(color)
	return getObjectFromGUID(playerStats[color][1]).Counter.getValue()
end

function getDeck(color)
    deckZone = getObjectFromGUID(zoneGUIDs[color][1]).getObjects()
    if #deckZone == 1 then
        return deckZone[1]
    end
    for k,v in pairs(deckZone) do
        if v.getName() == "" then
            return v
        end
    end
end

function drawCard(num, color) --draw num cards

	if num == 0 then
		return
	end
	myColor = color --color of player drawing.

	local deck = getDeck(color)

	if deck == nil then
		carryDraw = carryDraw + num
        --print("NO DECK - NEW CARRY: " .. carryDraw)
        startLuaCoroutine(Global, "takeDiscardFast")
		return
	end
    size = deck.getQuantity()
    --print(size)


    if size == -1 then
        deck.setPosition(zoneGUIDs[color][4])
        deck.flip()
        carryDraw = carryDraw + num - 1
        --print("LAST CARD - NEW CARRY: " .. carryDraw)
        startLuaCoroutine(Global, "takeDiscardFast")
        return
    end


    if num <= size then
        for i=1,num do
            drawnCard = deck.dealToColorWithOffset({0,0,0}, true, color)
            --print("DrawingA " .. num)
            --drawnCard.rotate({180,180,0})
        end
    else
        for i=1,size do
            drawnCard = deck.dealToColorWithOffset({0,0,0}, true, color)
            --print("DrawingB")
            --drawnCard.rotate({180,180,0})
        end
        carryDraw = carryDraw + num-size
        --print("TOO FEW CARDS - NEW CARRY: " .. carryDraw)
        startLuaCoroutine(Global, "takeDiscardFast")
    end
end

function emptyHand(color)
	local stackFlag = false
	local handCards = getObjectFromGUID(zoneGUIDs[color][2]).getObjects()
	if handCards == nil then
		return
	end
	local emptyDiscardPos = getObjectFromGUID(zoneGUIDs[color][3]).getPosition()
    local emptyDiscardRot = getObjectFromGUID(zoneGUIDs[color][3]).getRotation()
    emptyDiscardRot.z = 0
    emptyDiscardRot.y = math.abs(180 + emptyDiscardRot.y)
	emptyDiscardPos.y = 3.63
    if emptyDiscardRot.y > 360 then
            emptyDiscardRot.y = emptyDiscardRot.y - 360
    end
	for k,v in pairs(handCards) do
        --emptyDiscardPos.y = emptyDiscardPos.y + 0.1
		v.setPosition(emptyDiscardPos)
		v.setRotation(emptyDiscardRot)
	end

	for _,GUID in pairs(cardPlayed) do
		if GUID == nil then
			return
		end
		--emptyDiscardPos.y = emptyDiscardPos.y + 0.1
		local playedCard = getObjectFromGUID(GUID)
		if playedCard == nil then
			if stackFlag == false then
				printToColor("Error with cleaning up your cards.\nPlease try to avoid stacking them when playing on the table.\nYou will need to discard them manually.", color, {0.2,0.2,1})
				stackFlag = true
			end
		else
			playedCard.setPosition(emptyDiscardPos)
			playedCard.setRotation(emptyDiscardRot)
		end
	end
end

function takeDiscard()
    local thisColor = myColor
	for i=1, 40 do
		coroutine.yield(0)
	end
	local takeDeckPos = getObjectFromGUID(zoneGUIDs[thisColor][1]).getPosition()
	takeDeckPos.y = 10
	discard = getObjectFromGUID(zoneGUIDs[thisColor][3]).getObjects()[1]
	local takeDiscardPos = discard.getPosition()
	takeDiscardPos.y = 4
	discard.setPosition(takeDiscardPos)
	takeDiscardPos.y = 10
    local deckRot = getObjectFromGUID(zoneGUIDs[thisColor][1]).getRotation()
	takeDeckPos.y = 10
    deckRot.z = 180
    deckRot.y = math.abs(180 + deckRot.y)
    if deckRot.y > 360 then
        deckRot.y = deckRot.y - 360
    end
	discard.setPositionSmooth(takeDiscardPos)
	discard.flip()
	discard.shuffle()
	for i=1, 30 do
		coroutine.yield(0)
	end
	discard.setRotationSmooth(deckRot)
	for i=1, 30 do
		coroutine.yield(0)
	end
	discard.setPositionSmooth(takeDeckPos)
	for i=1, 60 do
		coroutine.yield(0)
	end
	--drawCard(carryDraw, thisColor) --draw remaining cards
	return 1
end

function addCard(GUID)
	cardPlayed[#cardPlayed+1] = GUID
end

function deleteCoins(num)
	for i=1, num do
		if #cleanup == 0 then
			break
		end
		destroyObject(cleanup[#cleanup])
		cleanup[#cleanup] = nil
		getObjectFromGUID(playerStats[TurnColor][1]).Counter.decrement()
	end
end

function spawnCoins()
	if TurnColor == "" then --dont spawn coins if game hasnt started yet
		return 1
	end
	local player = getPlayer(TurnColor)
	local handTable = player.getPlayerHand()
	coinPos = {handTable["pos_x"]/2, 6, handTable["pos_z"]/2}

	local param = {}
	param.type = "Custom_Model"

	for i=1, TREASURE do
		obj = spawnObject(param)
		obj.setName("Coin")
		obj.setPosition(coinPos)
		obj.setCustomObject(custom)
		startLuaCoroutine(Global, "wait5")
		table.insert(cleanup, obj)
		getObjectFromGUID(playerStats[TurnColor][1]).Counter.increment()
	end
	return 1
end

function wait5()
	for i=1, 5 do
		coroutine.yield(0)
	end
	return 1
end

function cardCounter(name) --finds deck size for supply cards
	local players = playerList
	local vic = 0
	local tre = 1
	if #players > 4 then
		vic = 3*(#players-4)
		tre = 1 + 0.25*(#players-4)
	end



	if name == "Copper" then
		cardNum = 60*tre
	elseif name == "Silver" then
		cardNum = 30*tre
	elseif name == "Gold" then
		cardNum = 20*tre
	elseif name == "Estate" then
        if #players == 2 then
            cardNum = 14
        else
            cardNum = 12 + 3*#players
        end
	elseif name == "Duchy" then
        if #players == 2 then
            cardNum = 8
        else
		    cardNum = 12
        end
	elseif name == "Province" then
        if #players == 2 then
            cardNum = 8
        else
		    cardNum = 12+vic
        end
	elseif name == "Curse" then
		cardNum = 10*#players - 10
        if #players == 1 then
            cardNum = 10
        end
	elseif name == "Colony" then
		cardNum = 12+vic
	elseif name == "Platinum" then
		cardNum = 20
	elseif name == "Potion" then
		cardNum = 30
	else
		cardNum = 10
	end
end

function Clone()
    cloneDone = false
	local loopCount = cardNum
	local newPos = {SupplyPos["x"][supplyKey], 3, SupplyPos["z"][supplyKey]}

	for i=1,loopCount do
		newPos[2] = newPos[2] + 0.2
		coroutine.yield(0)
		IBag.takeObject({position = newPos})
	end
	IBag.reset()
    cloneDone = true
	return 1
end

function findSupplyDeck()
	local obTable = getObjectFromGUID("c33945").getObjects()
	if #obTable < 2 then
		printToAll("Error: No Deck on left table.", {0.2,0.2,1})
		return nil
	end


	if obTable[1].getDescription() == "A very nice table" then
		return obTable[2]
    else
		return obTable[1]
	end
end

function findSpecificDeck()
	local obTable = getObjectFromGUID("ecf51a").getObjects()
	if #obTable < 2 then
		return nil
	end


	if obTable[1].getDescription() == "A really great table" then
		return obTable[2]
    else
		return obTable[1]
	end
end

function findDefaultDeck()
	local obTable = getObjectFromGUID("94dc28").getObjects()
	if #obTable < 2 then
		printToAll("Error: No Deck on right table.", {0.2,0.2,1})
		return nil
	end


	if obTable[1].getDescription() == "An exceptional table" then
		return obTable[2]
    else
		return obTable[1]
	end
end

function generateSupply()
	--Spawn default base values on player count 2-6
    playerList = getSeatedPlayers()
	local defaultDeck = findDefaultDeck()
    local specificDeck = findSpecificDeck()
	IBag = getObjectFromGUID("500b53")


	local params = {}
	params.position = {-1,2,16}
	params.rotation = {0,180,0}
	local supplyDeck = findSupplyDeck()
	for i=1, 30 do
		coroutine.yield(0)
	end
	if supplyDeck == nil or defaultDeck == nil then
		return 1
	end
    getObjectFromGUID(startButtonGUID).destruct()
    getObjectFromGUID(setupOnlyButtonGUID).destruct()
	supplyDeck.shuffle()
    if specificDeck ~= nil then
        specificDeck.setPositionSmooth({-4,5,12})
        specificDeck.setRotation({180,0,0})
        supplyDeck.setRotation({180,0,0})
    end

	local defSize = defaultDeck.getQuantity()

	for i=1, defSize do
		supplyKey = i
		if defaultDeck.getQuantity() > 0 then
			local params = {}
			params.position = {0,3,12}
			params.rotation = {0,180,0}
			params.guid = SupplyPos["GUID"][i]

			card = defaultDeck.takeObject(params)
			card.setLuaScript(genericCardEvent)
            card.use_snap_points = true
            local name = card.getName()
            Supply[name] = Default[name]
            supplySize = supplySize + 1
		else
			card = findDefaultDeck()
			card.setLuaScript(genericCardEvent)
            card.use_snap_points = true
            local name = card.getName()
            Supply[name] = Default[name]
            supplySize = supplySize + 1
			card.setPosition({0,3,12})
			card.setRotation({0,180,0})
		end
		for i=1, 60 do
			coroutine.yield(0)
		end
		cardCounter(card.getName())
		startLuaCoroutine(Global, "Clone")
		while cloneDone == false do  --needs to wait depending on size of stack.
			coroutine.yield(0)
		end
	end

	cardNum = 10
	for i=1, 10 do
		supplyKey = supplyKey + 1

		if supplyDeck.getQuantity() > 0 then
			local params = {}
			params.position = {0,3,12}
			params.rotation = {0,180,0}

			card = supplyDeck.takeObject(params)
			card.setLuaScript(genericCardEvent)
            card.use_snap_points = true
		else
			card = findSupplyDeck()
			card.setLuaScript(genericCardEvent)
            card.use_snap_points = true
			card.setPosition({0,3,12})
			card.setRotation({0,180,0})
		end

		local name = card.getName()
		Supply[name] = Base[name]
        supplySize = supplySize + 1
        for i=1, 60 do
			coroutine.yield(0)
		end
		startLuaCoroutine(Global, "Clone")
	end

    for i=1, 60 do
        coroutine.yield(0)
    end

    if supplyDeck ~= nil then
		supplyDeck.destruct()
	end
    if defaultDeck ~= nil then
		defaultDeck.destruct()
	end
	IBag.destruct()
	getObjectFromGUID("09a8c8").destruct() --bench
	getObjectFromGUID("692cf6").destruct() --bench
    getObjectFromGUID("08a8f4").destruct() --bench
	getObjectFromGUID("c33945").destruct() --deckZone
	getObjectFromGUID("94dc28").destruct() --deckZone

    for i=1, 60 do
        coroutine.yield(0)
    end


	startLuaCoroutine(Global, "dealHands")
	return 1
end

function dealHands()
	local obTable = getObjectFromGUID("36fe08").getObjects()
	for k,v in pairs(obTable) do
        if v.getQuantity() == -1 then
            --skip
		elseif v.getQuantity() < 50 then
			v.dealToAll(3)
		elseif v.getQuantity() > 50 then
			v.dealToAll(7)
		else
		end
	end

	for i=1, 120 do
		coroutine.yield(0)
	end
	for _,color in pairs(playerList) do
		local handCards = getObjectFromGUID(zoneGUIDs[color][2]).getObjects()
		if handCards == nil then
			return 1
		end
		local deckPos = getObjectFromGUID(zoneGUIDs[color][1]).getPosition()
        local deckRot = getObjectFromGUID(zoneGUIDs[color][1]).getRotation()
		deckPos.y = 4
        deckRot.z = 180
        deckRot.y = math.abs(180 + deckRot.y)
        if deckRot.y > 360 then
            deckRot.y = deckRot.y - 360
        end
		for k,v in pairs(handCards) do
			v.setPosition(deckPos)
			v.setRotation(deckRot)
		end
		for i=1, 30 do
			coroutine.yield(0)
		end
		drawCard(5, color)
	end
	return 1
end

function checkEnd() --returns false if game is over every turn
    local supplyObjects = getObjectFromGUID(supplyGUID).getObjects()
    local trashObjects = getObjectFromGUID(trashGUID).getObjects()
    local provDeck = getObjectFromGUID(provGUID).getObjects()
    provinceExists = false

    for k,v in pairs(provDeck) do
        if v.getDescription() ~= "Supply" then
            provinceExists = true
        end
    end

    supplyFull = #supplyObjects - #trashObjects

    if #playerList > 4 then
        if supplyFull + 3 < supplySize or provinceExists == false then
            return true
        else
            return false
        end
    else
        if supplyFull + 2 < supplySize or provinceExists == false then
            return true
        else
            return false
        end
    end
end

function gameOver()
    local highScore = 0
    local winner = ""
    for k,v in pairs(scoreTable) do
        if v > highScore then
            winner = k
            highScore = v
        end
    end
    ct = stringColorToRGB(winner)
    printToAll(getPlayer(winner).steam_name .. " wins with " .. highScore .. " points!", {ct.r, ct.g, ct.b})
end

function takeDiscardEND()
    for k,v in pairs(playerList) do
        if type(v) == "string" then
            myColor = v
            carryDraw = 0
            emptyHand(v)
            startLuaCoroutine(Global, "takeDiscard")
            for i=1, 300 do
        		coroutine.yield(0)
        	end
            myColor = v
            startLuaCoroutine(Global, "checkScore")
            for i=1, 100 do
        		coroutine.yield(0)
        	end
        end
    end
    gameOver()
    return 1
end

function checkScore()
	local deck = getObjectFromGUID(zoneGUIDs[myColor][1]).getObjects()[1]
	local deckTable = deck.getObjects()
	local score = 0
	for _,card in pairs(deckTable) do
		if card.nickname == "Estate" then
            score = score + 1
            deck.takeObject({position = zoneGUIDs[myColor][4], flip = true, guid = card.guid})
        elseif card.nickname == "Duchy" then
            score = score + 3
            deck.takeObject({position = zoneGUIDs[myColor][4], flip = true, guid = card.guid})
        elseif card.nickname == "Province" then
            score = score + 6
            deck.takeObject({position = zoneGUIDs[myColor][4], flip = true, guid = card.guid})
        elseif card.nickname == "Gardens" then
            score = score + Gardens(#deckTable)
            deck.takeObject({position = zoneGUIDs[myColor][4], flip = true, guid = card.guid})
        elseif card.nickname == "Curse" then
            score = score - 1
            deck.takeObject({position = zoneGUIDs[myColor][4], flip = true, guid = card.guid})
        end
        coroutine.yield(0)
	end

    scoreTable[myColor] = score
    ct = stringColorToRGB(myColor)
    printToAll(getPlayer(myColor).steam_name .. " has " .. score .. " points! ", {ct.r, ct.g, ct.b})

    return 1
end

function takeDiscardFast()

    for i=1, 2+waitStack do
        coroutine.yield(0)
    end

    local discardDeck = getObjectFromGUID(zoneGUIDs[myColor][3]).getObjects()[1]

    if discardDeck == nil then
        printToColor("No more cards!", color, {1,0,0})
        --for i=1,30 do
            --coroutine.yield(0)
        --end
        return 1
    end
    discardDeck.shuffle()
    local deckZone = getObjectFromGUID(zoneGUIDs[myColor][1])
    local deckPos = deckZone.getPosition()
    local discRot = discardDeck.getRotation()
    discRot.z = 180
    deckPos.y = 4

    discardDeck.setRotation(discRot)
    discardDeck.setPosition(deckPos)


    for i=1, 2+waitStack do
        coroutine.yield(0)
    end

    if carryDoneFlag == true then
        startLuaCoroutine(Global, "carryDrawCo") --draw remaining cards
    end

    return 1
end

function carryDrawCo()
    --print("STARTING DRAW - START CARRY: " .. carryDraw)
    carryDoneFlag = false
    for i=1,15 do
        coroutine.yield(0)
    end
    while carryDraw > 0 do
        --for i=1,5 do
            coroutine.yield(0)
        --end
        carryDraw = carryDraw - 1
        --print("CARD DRAWN - NEW CARRY: " .. carryDraw)
        drawCard(1, myColor)
    end
    carryDoneFlag = true
    --print("------------------------")
    return 1
end

function revealDeck(num, color)

    local deckPos = getObjectFromGUID(zoneGUIDs[color][1]).getPosition()
    local discard = getObjectFromGUID(zoneGUIDs[color][3]).getObjects()[1]


    for i=1,num do
        local revDeck = getObjectFromGUID(zoneGUIDs[color][1]).getObjects()[1]
        if revDeck == nil then
            if discard == nil then
                return
            end
            if revealDeckBypass(discard, deckPos, color) == true then
                return
            end
            myColor = color
            startLuaCoroutine(Global, "takeDiscardFast")
        elseif revDeck.getQuantity() > 0 then
            local revealedCard = revDeck.takeObject({position = {deckPos.x/mult[color], deckPos.y+(mult[color]/10), deckPos.z/mult[color]}, flip = true})
            revealedCard.setPosition({deckPos.x/mult[color], deckPos.y+(mult[color]/10), deckPos.z/mult[color]})
        else
            revDeck = getObjectFromGUID(zoneGUIDs[color][1]).getObjects()[1]
            revDeck.setPosition({deckPos.x/mult[color], deckPos.y+(mult[color]/10), deckPos.z/mult[color]})
            myColor = color
            startLuaCoroutine(Global, "takeDiscardFast")
            revDeck.flip()
            revDeck.rotate({0,180,0})
        end
        mult[color] = mult[color] + 0.1
    end
end

function revealDeckBypass(revByDeck, deckPos, color)
    if revByDeck == nil then -- discard is empty
        return true
    end
    if revByDeck.getQuantity() > 0 then
        revByDeck.shuffle()
        local revealedCard = revByDeck.takeObject({position = {deckPos.x/mult[color], deckPos.y+(mult[color]/10), deckPos.z/mult[color]}, flip = false})
        revealedCard.setPosition({deckPos.x/mult[color], deckPos.y+(mult[color]/10), deckPos.z/mult[color]})
    else
        revByDeck = getObjectFromGUID(zoneGUIDs[color][1]).getObjects()[1]
        revByDeck.setPosition({deckPos.x/mult[color], deckPos.y+(mult[color]/10), deckPos.z/mult[color]})
        return true
    end
    return false
end

function resetFlags()
    AdFlag = 0
    TRFlag = 0
    TRstack = 0
    trashedFlag = 0
    MineFlag = 0
    WSFlag = 0
    RemodelFlag = 0
    MLFlag = 0
    FeastFlag = 0
    mult = {
        White = 1.3,
        Red = 1.5,
        Purple = 1.3,
        Orange = 1.3,
        Green = 1.3,
        Blue = 1.5
    }
    revCount = 0
end

function moatTableReset()
    if moatTable == nil then
        return
    end
    for color,_ in pairs(moatTable) do
        moatTable[color] = false
    end
end

function checkMoat(color) -- Reveals a Moat if it exists in player hand
    if type(color) ~= "string" then;
        return false
    end
	local hand = getObjectFromGUID(zoneGUIDs[color][2]).getObjects()
    if moatTable[color] == true then
        return true
    end

	for _,obj in pairs(hand) do
        if obj.getName() == "Moat" then
            local obPos = obj.getPosition()
            obPos.x = obPos.x/1.5
            obPos.z = obPos.z/1.5
            obj.setPositionSmooth(obPos)
            moatTable[color] = true
            return true
        end
    end
	return false
end

function Gardens(deckSize) --Calculates value of garden card based on deck size
	vp = math.floor(deckSize/10)
	return vp
end

function Adventurer()
    AdFlag = 2
    startLuaCoroutine(Global, "CoAdventurer")
end

function CoAdventurer()
    local color = TurnColor
    local initX = revPosTable[color][1]
    local initZ = revPosTable[color][2]
    local Xinc = revPosTable[color][3]*1.5
    local Zinc = revPosTable[color][4]*1.5
    local resetX = revPosTable[color][5]
    local resetZ = revPosTable[color][6]
    local newPos = {initX, 3, initZ}
    local overflow = 0
    local adDeck = getObjectFromGUID(zoneGUIDs[color][1]).getObjects()[1]
    local tCleanup = {}
    local oCleanup = {}
    local adCardName = ""
    local discPos = getObjectFromGUID(zoneGUIDs[color][3]).getPosition()
    discPos.y = 4

    while AdFlag > 0 do
        if adDeck == nil then
            startLuaCoroutine(Global, "takeDiscardFast")
            for i=1,20 do
                coroutine.yield(0)
            end
            adDeck = getObjectFromGUID(zoneGUIDs[color][1]).getObjects()[1]
            if adDeck == nil then
                break
            end
        end

        if adDeck.getQuantity() > 0 then
            adCard = adDeck.takeObject({position = newPos, flip = true})
            adCard.setPosition(newPos)
        else
            adCard = adDeck
            adCard.setPosition(newPos)
            myColor = color
            adCard.flip()
        end


        for i=1,20 do
            coroutine.yield(0)
        end

        adCardName = adCard.getName()

        if adCardName == "Copper" or adCardName == "Silver" or adCardName == "Gold" or adCardName == "Platinum" then
            AdFlag = AdFlag - 1
            tCleanup[#tCleanup+1] = adCard
        else
            oCleanup[#oCleanup+1] = adCard
        end

        newPos[1] = newPos[1] + Xinc
        newPos[3] = newPos[3] + Zinc
        overflow = overflow + 1

        if overflow > 10 then
            initX = initX + resetX
            initZ = initZ + resetZ
            newPos = {initX, 3, initZ}
            overflow = 0
        end
        adDeck = getObjectFromGUID(zoneGUIDs[color][1]).getObjects()[1]
    end

    for i=1,60 do
        coroutine.yield(0)
    end

    for _,card in pairs(tCleanup) do
        if card == nil then
            --skip
        else
            card.translate({0,2,0})
            for i=1,15 do
                coroutine.yield(0)
            end
            card.setPositionSmooth(zoneGUIDs[color][4])
            coroutine.yield(0)
        end
    end

    for i=1,60 do
        coroutine.yield(0)
    end

    for _,card in pairs(oCleanup) do
        if card == nil then
            --skip
        else
            card.setPosition(discPos)
            coroutine.yield(0)
        end
        discPos.y = discPos.y + 0.2
    end
    oCleanup = {}
    tCleanup = {}

    return 1
end

function Bureaucrat()
    --gain silver
    local silverDeck = getObjectFromGUID(silverGUID).getObjects()
    local deckPos = getObjectFromGUID(zoneGUIDs[TurnColor][1]).getPosition()
    deckPos.y = deckPos.y + 4
    for k,v in pairs(silverDeck) do
        if v.getDescription() ~= "Supply" then
            if v.getQuantity() > 0 then
                local thisCard = v.takeObject({position = deckPos, flip = true})
                thisCard.setPosition(deckPos)
            else
                v.setPosition(deckPos)
                v.flip()
            end
        end
    end

    for _,color in pairs(playerList) do
        if type(color) == "string" then
            cardfound = true

            burHandTable = getObjectFromGUID(zoneGUIDs[color][2]).getObjects()
            if color ~= TurnColor and checkMoat(color) == false then
                cardfound = false
                for k,v in pairs(burHandTable) do
                    for i,j in pairs(VictoryTable) do
                        if v.getName() == i then
                            local deckPos = getObjectFromGUID(zoneGUIDs[color][1]).getPosition()
                            deckPos.y = 5
                            v.setPosition(deckPos) --place VP on deck
                            v.flip()
                            cardfound = true
                            break
                        end
                    end
                    if cardfound == true then break end
                end

                if cardfound == false then --reveal hand
                    for k,v in pairs(burHandTable) do
                        local vPos = v.getPosition()
                        v.setPosition({vPos.x/1.5, vPos.y, vPos.z/1.5})
                    end
                end
            end
        end
    end
end

function Cellar()
    return
end

function Chapel()
end

function Chancellor()
    return
end

function Council_Room()
    startLuaCoroutine(Global, "CoCR")
end

function CoCR()
    for i=1,30 do
        coroutine.yield(0)
    end
    for _,color in pairs(playerList) do
        if color ~= TurnColor and type(color) == "string" then
            for i=1,10 do
                coroutine.yield(0)
            end
            drawCard(1, color)
        end
    end
    return 1
end

function Feast()
    FeastFlag = FeastFlag + 1
end

function Library()
end

function Militia()
end

function Mine()
    MineFlag = MineFlag + 1
end

function Moneylender()
    MLFlag = MLFlag + 1
end

function Remodel()
    RemodelFlag = RemodelFlag + 1
end

function Spy()
    revCount = 1
    startLuaCoroutine(Global, "CoSpy")
end

function CoSpy()
    for i=1, revCount do
        for i=1,10 do
            coroutine.yield(0)
        end
        for _,color in pairs(playerList) do
            if color == TurnColor or checkMoat(color) == false then
                if type(color) == "string" then
                    revealDeck(1, color)
                end
            end
        end
    end
    return 1
end

function Thief()
    revCount = 2
    startLuaCoroutine(Global, "CoThief")
end

function CoThief()
    for i=1, revCount do
        for i=1,10 do
            coroutine.yield(0)
        end
        for _,color in pairs(playerList) do
            if color ~= TurnColor and checkMoat(color) == false then
                if type(color) == "string" then
                    revealDeck(1, color)
                end
            end
        end
    end
    return 1
end

function Throne_Room()
    TRFlag = TRFlag + 2
end

function CoTR()
    for i=1,10 do
        coroutine.yield(0)
    end
    if Supply[TRCardName][6] == 1 then --call specific card function
		Global.call(TRCardName)
	end
    return 1
end

function Witch()
    local curses = getObjectFromGUID(curseGUID).getObjects()
    if #curses == 1 then return end

    for k,v in pairs(curses) do
        if v.getDescription() ~= "Supply" then
            curseDeck = v
        end
    end
    for _,color in pairs(playerList) do
        if color ~= TurnColor and type(color) == "string" then
            if checkMoat(color) == false then
                local discardPos = getObjectFromGUID(zoneGUIDs[color][3]).getPosition()
                discardPos.y = 3.63
                if curseDeck.getQuantity() > 0 then
                    thisCurse = curseDeck.takeObject({position = discardPos})
                    thisCurse.setPosition(discardPos)
                else
                    curses = getObjectFromGUID(curseGUID).getObjects()
                    for k,v in pairs(curses) do
                        if v.getName() == "Curse" then
                            thisCurse = v
                        end
                    end
                    thisCurse.setPosition(discardPos)
                    return
                end
            end
        end
    end
end

function Workshop()
    WSFlag = WSFlag + 1
end