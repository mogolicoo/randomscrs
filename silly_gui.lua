-- // services 
local players = game:GetService("Players");
local repStorage = game:GetService("ReplicatedStorage");
local runService = game:GetService("RunService");

-- // other shit 
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))();
local gui = lib.CreateLib("Ebic Condo GUI", "DarkTheme");
local animation_names =  {
    ["Chupar"] = "F",
    ["Perrito"] = "G",
    ["Abrirse"] = "a",
    ["Twerk"] = "c",
    ["Doblar"] = "i",
    ["Violar"] = "d",
    ["Inversa"] = "h",
    ["M/Tocar"] = "O",
    ["Abrazo"] = "b",
}
local morph_names = {
    ["Hombre"] = "man",
    ["Mujer"] = "woman",
    ["Hombre y mujer"] = "wm",
    ["Culo"] = "ass"
}

-- // objects
local lplayer = players.LocalPlayer;
local pgui = lplayer:FindFirstChildOfClass("PlayerGui");

-- // variables
local selectedVictim;
local adminVictim1;
local adminVictim2;

local selectedAnim;
local selectedMsg;
local selectedEMsg;
local selectedMorph;

local loop1Enabled = false;

-- // tabs
local main = gui:NewTab("Principal");
local admin = gui:NewTab("Admin");
local creditstab = gui:NewTab("Creditos");

-- // sections
local thirdSection = main:NewSection("Configuración")
local firstSection = main:NewSection("Scripts principales")
local secondSection = main:NewSection("Scripts miscelaneos")

local admin3 = admin:NewSection("Configuración")
local admin1 = admin:NewSection("Scripts principales (no abusar o te baneara)")
local admin2 = admin:NewSection("Scripts miscelaneos")

local credits = creditstab:NewSection("Creditos:")

-- // credits 
credits:NewLabel("Matias - Scripts del gui")
credits:NewLabel("Martin - Apoyo emocional")
credits:NewLabel("xHeptc - Kavo UI Library")

-- // main scripts
firstSection:NewButton("Kickear del cuarto", "Kickea a la victima de los cuartos.<br><b>Puede que funcione o tal vez no.</b></br>", function()
    if not selectedVictim then 
        return
    end 
    repStorage.Folder.KickRoom:FireServer(
        selectedVictim.Character.Tp.room.Value,
        selectedVictim,
        2,
        "KickOwner"
    )
end)
firstSection:NewButton("Forzar mensaje", "La victima mandara un mensaje al chat.<br>  (no ejecutara comandos)</br>", function()
    if not selectedVictim then
        return 
    end 
    repStorage.NewChat.Send:FireServer(selectedMsg, selectedVictim.Name)
end)
firstSection:NewTextBox("Mensaje privado", "Manda mensaje privado a la victima<br>  sin tiempo de espera.</br>", function(txt)
    if not selectedVictim then
        return 
    end 
    repStorage.Folder.Sendmessage:FireServer(selectedVictim, txt)
end)
firstSection:NewButton("Eliminar mensajes", "Elimina todos los mensajes del chat.", function()
    for i,v in next, pgui.NewChat.Bar2.ScrollFrame:GetChildren() do 
        if v:FindFirstChild'ID' and v.ID:IsA'StringValue' then 
            repStorage.NewChat.RemoveMessage:FireServer(v.ID.Value)
        end
    end 
end)
firstSection:NewButton("Editar mensajes", "Edita todos los mensajes del chat.", function()
    if not selectedEMsg then
        return
    end 
    for i,v in next, pgui.NewChat.Bar2.ScrollFrame:GetChildren() do 
        if v:FindFirstChild'ID' and v.ID:IsA'StringValue' then 
            repStorage.NewChat.EditMessage:FireServer(v.ID.Value, selectedEMsg)
        end
    end 
end)

secondSection:NewButton("Enviar petición de teletransportación", "Manda una petición de teletransportación<br>  con el nombre de la victima.</br>", function()
    if not selectedVictim then
        return 
    end 
    repStorage.NewChat.Requets.TeleportRequets:FireServer(selectedVictim.Name)
end)
secondSection:NewButton("Enviar petición de collar", "Manda una petición de collar<br>  con el nombre de la victima.</br>", function()
    if not selectedVictim then
        return 
    end 
    repStorage.NewChat.Requets.RequetsCollarOthers:FireServer(selectedVictim.Name)
end)
secondSection:NewButton("Forzar collar a todos", "Hara que todos tengan collar en ti en un bucle.", function()
    for i, victim in next, players:GetPlayers() do 
        if (victim ~= players.LocalPlayer) then 
            repStorage.Folder.j:FireServer(victim)
        end 
    end 
end)
secondSection:NewButton("Desactivar nombres editados", "Cambiara los nombres de todos<br>al de sus displays originales (LOCAL).</br>", function()
    for _,v in next, players:GetPlayers() do 
        for _,vv in next, v.Character:GetDescendants() do 
            if vv:IsA("Humanoid") then 
                vv.DisplayName = v.DisplayName
            end 
        end 
    end 
end)

-- // main toggles
-- firstSection:NewToggle("Desactivar cuartos", "Kickea a todos de los cuartos en un bucle<br>  haciendo que sean inutilizables.</br>")
secondSection:NewToggle("Cubrir pantalla", "Cubre la pantalla de todos los jugadores excepto a ti.", function(bool)
    loop1Enabled = bool
end)
-- secondSection:NewToggle("Ver mensajes privados", "Hara que los mensajes privados sean visibles.")

-- // admin stuff
admin1:NewButton("Teletransportar", "Trae la victima 1 a tu posición.", function()
    if not adminVictim1 then
        return
    end
    repStorage.Folder.Folder.ServerEvents:FireServer(adminVictim1,{"Tp","Tp",players.LocalPlayer})
end)
admin1:NewButton("Collar", "Hace que la victima 1 tenga collar de victima 2.", function()
    if not adminVictim1 then
        return
    end
    repStorage.Folder.Folder.ServerEvents:FireServer(adminVictim1,{"Collar","Collar",players.LocalPlayer})
end)
admin1:NewButton("Usar morph", "Hace que la victima 1 use un morph.", function()
    if not adminVictim1 then
        return
    end
    if not selectedMorph then
        return
    end
    repStorage.Folder.Folder.ServerEvents:FireServer(adminVictim1,{"Morph",selectedMorph,players.LocalPlayer})
end)
admin1:NewButton("Usar animación", "Hace que la victima 1 use una animación.", function()
    if not adminVictim1 then
        return
    end
    if not selectedAnim then
        return
    end 
    -- print(selectedAnim)
    -- repStorage.Folder.Folder.ServerEvents:FireServer(adminVictim1,{"Anim",selectedAnim,players.LocalPlayer})
    repStorage.anims:FireServer(adminVictim1, "stop", 0, 0)
    repStorage.anims:FireServer(adminVictim1.Character, "load", 1, selectedAnim)
end)
admin1:NewButton("Violación (victima 2 coje a victima 1)", "Hace que la victima 1 y victima 2 esten cojiendo.", function()
    if not adminVictim1 then
        return
    end
    if not adminVictim2 then
        return
    end 
    workspace.EventsRPGUI.fun:FireServer("Fun", adminVictim1.Name, adminVictim2.Name);
    repStorage.anims:FireServer(adminVictim2.Character, "load", 1, "d"); 
    repStorage.anims:FireServer(adminVictim1.Character, "load", 1, "g"); 
end)

admin2:NewTextBox("Mensaje global", "Enviara un mensaje a todo el servidor.", function(txt)
    for i,v in next, players:GetPlayers() do 
        repStorage.Folder.Msgdata:FireServer(v, txt)
    end 
end)

admin2:NewTextBox("Cambiar nombre", "Cambiara el nombre de la victima 1.", function(txt)
    if not adminVictim1 then
        return
    end
    workspace.EventsRPGUI.ChangeBioEvent:FireServer(txt, adminVictim1.Name)
end)

admin2:NewButton("Montar", "Hace que la victima 1 este montado en ti.", function()
    if not adminVictim1 then
        return
    end
    workspace.ride.Ride:FireServer(adminVictim1.Character,"Ride")
end)

-- // main settings
thirdSection:NewLabel("Victima:")
local plrDropdown1 = thirdSection:NewDropdown("Ninguno seleccionado", "Elige la victima para los scripts.", {}, function(txt)
    local shit = string.split(txt, "(")[2]
    shit = string.sub(shit, 2, #shit-1)
    if players:FindFirstChild(shit) then
        selectedVictim = players[shit]
        print(selectedVictim)
    end
end)

local label1 = thirdSection:NewLabel("Mensaje de chat: <b>nil</b>")
thirdSection:NewTextBox("Mensaje de chat", "Pon el mensaje que mandara la victima en el chat.", function(txt)
    label1:UpdateLabel("Mensaje de chat: <b>"..txt.."</b>")
    selectedMsg = txt
end)
local label2 = thirdSection:NewLabel("Nuevo mensaje: <b>nil</b>")
thirdSection:NewTextBox("Nuevo mensaje", "Pon a lo que quieres que los mensajes sean editados.", function(txt)
    label2:UpdateLabel("Nuevo mensaje: <b>"..txt.."</b>")
    selectedEMsg = txt
end)

-- // admin settings
admin3:NewLabel("Victima 1 (pasivo):")
local adminPlrDropdown1 = admin3:NewDropdown("Ninguno seleccionado", "Elige la victima para los scripts.", {}, function(txt)
    local shit = string.split(txt, "(")[2]
    shit = string.sub(shit, 2, #shit-1)
    if players:FindFirstChild(shit) then
        adminVictim1 = players[shit]
        -- print(adminVictim1)
    end
end)

admin3:NewLabel("Victima 2 (activo):")
local adminPlrDropdown2 = admin3:NewDropdown("Ninguno seleccionado", "Elige la victima para los scripts.", {}, function(txt)
    local shit = string.split(txt, "(")[2]
    shit = string.sub(shit, 2, #shit-1)
    if players:FindFirstChild(shit) then
        adminVictim2 = players[shit]
        -- print(adminVictim2)
    end
end)

admin3:NewLabel("Animacion seleccionada:")
admin3:NewDropdown("Animaciones", "Elige la animación para los scripts.", {"Chupar","Perrito","Abrirse","Twerk","Doblar","Violar","Inversa","M/Tocar","Abrazo"}, function(txt)
    selectedAnim = animation_names[txt]
    -- print(selectedAnim)
end)

admin3:NewLabel("Morph seleccionada:")
admin3:NewDropdown("Morphs", "Elige la animación para los scripts.", {"Hombre","Mujer","Hombre y mujer","Culo"}, function(txt)
    selectedMorph = morph_names[txt]
    -- print(selectedAnim)
end)

-- // some shit for dropdowns
do 
    local tempTbl = {};
    for _, plr in next, players:GetPlayers() do
        table.insert(tempTbl, plr.DisplayName.." (@"..plr.Name..")")
    end
    plrDropdown1:Refresh(tempTbl)
    adminPlrDropdown1:Refresh(tempTbl)
    adminPlrDropdown2:Refresh(tempTbl)
end 

players.PlayerAdded:Connect(function()
    local tempTbl = {};
    for _, plr in next, players:GetPlayers() do
        table.insert(tempTbl, plr.DisplayName.." (@"..plr.Name..")")
    end
    plrDropdown1:Refresh(tempTbl)
    adminPlrDropdown1:Refresh(tempTbl)
    adminPlrDropdown2:Refresh(tempTbl)
end)

players.PlayerRemoving:Connect(function()
    local tempTbl = {};
    for _, plr in next, players:GetPlayers() do
        table.insert(tempTbl, plr.DisplayName.." (@"..plr.Name..")")
    end
    plrDropdown1:Refresh(tempTbl)
    adminPlrDropdown1:Refresh(tempTbl)
    adminPlrDropdown2:Refresh(tempTbl)
end)

-- // loops
runService.RenderStepped:Connect(function()
    if loop1Enabled then
        for i,v in next, players:GetPlayers() do 
            if (v ~= players.LocalPlayer) then 
                repStorage.Folder.Msgdata:FireServer(v, "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
            end
        end 
    end
end)
