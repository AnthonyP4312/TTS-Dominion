function onload()
    params = {}
    params.click_function = "startGame"
    params.function_owner = self
    params.label = "Start\nGame"
    params.width = 400
    params.height = 400
    params.rotation = {0,0,180}
    self.createButton(params)
end

function startGame()
    startLuaCoroutine(Global, "generateSupply")
end