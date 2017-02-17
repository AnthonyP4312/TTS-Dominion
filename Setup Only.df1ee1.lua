function onload()
    params = {}
    params.click_function = "startGame"
    params.function_owner = self
    params.label = "Setup\nOnly"
    params.width = 400
    params.height = 400
    params.rotation = {0,0,180}
    self.createButton(params)
end

function startGame()
    Global.call("setupOnly")
    startLuaCoroutine(Global, "generateSupply")
end