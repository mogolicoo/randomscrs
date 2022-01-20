-- r15 to r6 with old roblox animations
-- just combined and edited two r15 reanimation scripts and added the old r6 animations
-- credits to their respective owners:
-- https://pastebin.com/raw/XTH2H4gG (r15 to r6 reanimation script)
-- https://v3rmillion.net/showthread.php?tid=1073859 (r15 reanimation base script)
-- https://v3rmillion.net/showthread.php?tid=1114784 (netless)

game.Players.LocalPlayer.Character.Animate.Disabled = true
for i,v in next, game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks() do v:Stop() end
-- removing ragdoll shit from character
for _, obj in next, game.Players.LocalPlayer.Character:GetDescendants() do
    if obj:IsA'BallSocketConstraint' then
        obj:Destroy()
    end
end
wait(0.55)
local connections = {}
local char = game:GetObjects("rbxassetid://5194310703")[1]
local oldChar = game.Players.LocalPlayer.Character;
char.Parent = oldChar
e = game:GetService'RunService'.RenderStepped:Connect(function()
	for i,v in next, oldChar.Humanoid:GetPlayingAnimationTracks() do v:Stop() end
end)
spawn(function()
	local rs = game:GetService("RunService")
	-- netless
    table.insert(connections, rs.Heartbeat:Connect(function()
        setsimulationradius(math.huge, math.huge)
        --sethiddenproperty(game.Players.LocalPlayer,"MaximumSimulationRadius",math.huge)
        --sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",999999999)
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
		settings().Physics.AllowSleep = false
        settings().Physics.ThrottleAdjustTime = math.huge-math.huge
    end))
    for i,v in next, oldChar:GetDescendants() do
        if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then
            table.insert(connections, game:GetService("RunService").Heartbeat:connect(function()
                v.Velocity = Vector3.new(30,0,4)
                v.Velocity = Vector3.new(30,4,0)
            end))
        end
    end
    -- Noclipping
	table.insert(connections, rs.Stepped:Connect(function()
		char:FindFirstChild("Head").CanCollide = false
		char:FindFirstChild("Torso").CanCollide = false
		char:FindFirstChild("HumanoidRootPart").CanCollide = false
		pcall(function() oldChar.HumanoidRootPart.CanCollide = false end)
		oldChar.Head.CanCollide = false
		oldChar.UpperTorso.CanCollide = false
		oldChar.LowerTorso.CanCollide = false
	end))
	table.insert(connections, rs.Heartbeat:Connect(function()
		char:FindFirstChild("Head").CanCollide = false
		char:FindFirstChild("Torso").CanCollide = false
		char:FindFirstChild("HumanoidRootPart").CanCollide = false
		pcall(function() oldChar.HumanoidRootPart.CanCollide = false end)
		oldChar.Head.CanCollide = false
		oldChar.UpperTorso.CanCollide = false
		oldChar.LowerTorso.CanCollide = false
	end))
	table.insert(connections, rs.RenderStepped:Connect(function()
		char:FindFirstChild("Head").CanCollide = false
		char:FindFirstChild("Torso").CanCollide = false
		char:FindFirstChild("HumanoidRootPart").CanCollide = false
		pcall(function() oldChar.HumanoidRootPart.CanCollide = false end)
		oldChar.Head.CanCollide = false
		oldChar.UpperTorso.CanCollide = false
		oldChar.LowerTorso.CanCollide = false
	end))
end)
for i,v in pairs(char:GetDescendants()) do
	if v:IsA("BasePart") then
		local prt=v
		prt:GetPropertyChangedSignal("Transparency"):Connect(function()
			prt.Transparency=1
		end)
		if v.Name~="Head" and v.Name~="Torso" and v.Name~="HumanoidRootPart" then
			prt.CanCollide=false
			prt:GetPropertyChangedSignal("CanCollide"):Connect(function()
				prt.CanCollide=false
			end)
		end
	end
end
-- anims
spawn(function()
	function waitForChild(parent, childName)
		local child = parent:findFirstChild(childName)
		if child then return child end
		while true do
			child = parent.ChildAdded:wait()
			if child.Name==childName then return child end
		end
	end
	local Figure = char
	waitForChild(Figure, "Animate").Disabled = true
	-- ANIMATION
	-- declarations
	local Humanoid = waitForChild(Figure, "Humanoid")
	-- empty variables
	local Torso = waitForChild(Figure, "Torso")
	local RightShoulder = waitForChild(Torso, "Right Shoulder")
	local LeftShoulder = waitForChild(Torso, "Left Shoulder")
	local RightHip = waitForChild(Torso, "Right Hip")
	local LeftHip = waitForChild(Torso, "Left Hip")
	local Neck = waitForChild(Torso, "Neck")
	local pose = "Standing"
	local toolAnim = "None"
	local toolAnimTime = 0
	local jumpMaxLimbVelocity = 0.75
	-- functions
	function onRunning(speed)
		if speed>0 then
			pose = "Running"
		else
			pose = "Standing"
		end
	end

	function onDied()
		pose = "Dead"
	end

	function onJumping()
		pose = "Jumping"
	end

	function onClimbing()
		pose = "Climbing"
	end

	function onGettingUp()
		pose = "GettingUp"
	end

	function onFreeFall()
		pose = "FreeFall"
	end

	function onFallingDown()
		pose = "FallingDown"
	end

	function onSeated()
		pose = "Seated"
	end

	function onPlatformStanding()
		pose = "PlatformStanding"
	end

	function onSwimming(speed)
		if speed>0 then
			pose = "Running"
		else
			pose = "Standing"
		end
	end

	function moveJump()
		RightShoulder.MaxVelocity = jumpMaxLimbVelocity
		LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
		RightShoulder:SetDesiredAngle(3.14)
		LeftShoulder:SetDesiredAngle(-3.14)
		RightHip:SetDesiredAngle(0)
		LeftHip:SetDesiredAngle(0)
	end


	-- same as jump for now

	function moveFreeFall()
		RightShoulder.MaxVelocity = jumpMaxLimbVelocity
		LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
		RightShoulder:SetDesiredAngle(3.14)
		LeftShoulder:SetDesiredAngle(-3.14)
		RightHip:SetDesiredAngle(0)
		LeftHip:SetDesiredAngle(0)
	end

	function moveSit()
		RightShoulder.MaxVelocity = 0.15
		LeftShoulder.MaxVelocity = 0.15
		RightShoulder:SetDesiredAngle(3.14 /2)
		LeftShoulder:SetDesiredAngle(-3.14 /2)
		RightHip:SetDesiredAngle(3.14 /2)
		LeftHip:SetDesiredAngle(-3.14 /2)
	end

	function getTool()
		for _, kid in ipairs(Figure:GetChildren()) do
			if kid.className == "Tool" then return kid end
		end
		return nil
	end

	function getToolAnim(tool)
		for _, c in ipairs(tool:GetChildren()) do
			if c.Name == "toolanim" and c.className == "StringValue" then
				return c
			end
		end
		return nil
	end

	function animateTool()

		if (toolAnim == "None") then
			RightShoulder:SetDesiredAngle(1.57)
			return
		end

		if (toolAnim == "Slash") then
			RightShoulder.MaxVelocity = 0.5
			RightShoulder:SetDesiredAngle(0)
			return
		end

		if (toolAnim == "Lunge") then
			RightShoulder.MaxVelocity = 0.5
			LeftShoulder.MaxVelocity = 0.5
			RightHip.MaxVelocity = 0.5
			LeftHip.MaxVelocity = 0.5
			RightShoulder:SetDesiredAngle(1.57)
			LeftShoulder:SetDesiredAngle(1.0)
			RightHip:SetDesiredAngle(1.57)
			LeftHip:SetDesiredAngle(1.0)
			return
		end
	end

	function move(time)
		local amplitude
		local frequency

		if (pose == "Jumping") then
			moveJump()
			return
		end

		if (pose == "FreeFall") then
			moveFreeFall()
			return
		end

		if (pose == "Seated") then
			moveSit()
			return
		end

		local climbFudge = 0

		if (pose == "Running") then
			if (RightShoulder.CurrentAngle > 1.5 or RightShoulder.CurrentAngle < -1.5) then
				RightShoulder.MaxVelocity = jumpMaxLimbVelocity
			else  
				RightShoulder.MaxVelocity = 0.15
			end
			if (LeftShoulder.CurrentAngle > 1.5 or LeftShoulder.CurrentAngle < -1.5) then
				LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
			else  
				LeftShoulder.MaxVelocity = 0.15
			end
			amplitude = 1
			frequency = 9
		elseif (pose == "Climbing") then
			RightShoulder.MaxVelocity = 0.5
			LeftShoulder.MaxVelocity = 0.5
			amplitude = 1
			frequency = 9
			climbFudge = 3.14
		else
			amplitude = 0.1
			frequency = 1
		end

		desiredAngle = amplitude * math.sin(time*frequency)

		RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
		LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
		RightHip:SetDesiredAngle(-desiredAngle)
		LeftHip:SetDesiredAngle(-desiredAngle)


		local tool = getTool()

		if tool then

			animStringValueObject = getToolAnim(tool)

			if animStringValueObject then
				toolAnim = animStringValueObject.Value
				-- message recieved, delete StringValue
				animStringValueObject.Parent = nil
				toolAnimTime = time + .3
			end

			if time > toolAnimTime then
				toolAnimTime = 0
				toolAnim = "None"
			end

			animateTool()


		else
			toolAnim = "None"
			toolAnimTime = 0
		end
	end


	-- connect events

	Humanoid.Died:connect(onDied)
	Humanoid.Running:connect(onRunning)
	Humanoid.Jumping:connect(onJumping)
	Humanoid.Climbing:connect(onClimbing)
	Humanoid.GettingUp:connect(onGettingUp)
	Humanoid.FreeFalling:connect(onFreeFall)
	Humanoid.FallingDown:connect(onFallingDown)
	Humanoid.Seated:connect(onSeated)
	Humanoid.PlatformStanding:connect(onPlatformStanding)
	Humanoid.Swimming:connect(onSwimming)
	-- main program
	local runService = game:service("RunService");

	while Figure.Parent~=nil do
		local _, time = wait(0.1)
		move(time)
	end
end)

local function Align(Part1, Part0, Position, Angle)
	Part1.CanCollide = false

	local AlignPos = Instance.new("AlignPosition")
	AlignPos.ApplyAtCenterOfMass = true
	AlignPos.MaxForce = 100000
	AlignPos.MaxVelocity = math.huge
	AlignPos.ReactionForceEnabled = false
	AlignPos.Responsiveness = 200
	AlignPos.RigidityEnabled = false
	AlignPos.Parent = Part1

	local AlignOri = Instance.new("AlignOrientation")
	AlignOri.MaxAngularVelocity = math.huge
	AlignOri.MaxTorque = 100000
	AlignOri.PrimaryAxisOnly = false
	AlignOri.ReactionTorqueEnabled = false
	AlignOri.Responsiveness = 200
	AlignOri.RigidityEnabled = false
	AlignOri.Parent = Part1

	local at1 = Instance.new("Attachment")
	at1.Parent = Part1
	local at2 = Instance.new("Attachment")
	at2.Parent = Part0
	at2.Orientation = Angle
	at2.Position = Position

	AlignPos.Attachment0 = at1
	AlignPos.Attachment1 = at2
	AlignOri.Attachment0 = at1
	AlignOri.Attachment1 = at2
end
game.Players.LocalPlayer.Character.RightUpperArm["RightShoulder"]:Destroy()
game.Players.LocalPlayer.Character.LeftUpperArm["LeftShoulder"]:Destroy()
game.Players.LocalPlayer.Character.RightUpperLeg["RightHip"]:Destroy()
game.Players.LocalPlayer.Character.LeftUpperLeg["LeftHip"]:Destroy()
game.Players.LocalPlayer.Character.Head.CanCollide=false
Align(game.Players.LocalPlayer.Character:FindFirstChild("LeftUpperArm"),char["Left Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
Align(game.Players.LocalPlayer.Character:FindFirstChild("RightUpperArm"),char["Right Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
Align(game.Players.LocalPlayer.Character:FindFirstChild("LeftUpperLeg"),char["Left Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
Align(game.Players.LocalPlayer.Character:FindFirstChild("RightUpperLeg"),char["Right Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
Align(game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso"),char["Torso"],Vector3.new(0,0.5,0),Vector3.new(0,0,0))
char:MoveTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position)
game.Players.LocalPlayer.Character.Animate.Disabled = true
game.Players.LocalPlayer.Character.LowerTorso.Root:Destroy()
char.HumanoidRootPart.Anchored = false
game.Workspace.CurrentCamera.CameraSubject = char.Humanoid
game.Players.LocalPlayer.Character.HumanoidRootPart:Destroy()
oc=game.Players.LocalPlayer.Character 
eeeee2=char.Humanoid.Died:Connect(function()
	game.Players.LocalPlayer.Character = oc
	oc.Humanoid.Health=0
	oc:BreakJoints()
	char.Humanoid.Health=0
	char:BreakJoints()
	char:Destroy()
	for _,v in pairs(connections) do v:Disconnect() end
    e:Disconnect()
end)
game.Players.LocalPlayer.Character = char
