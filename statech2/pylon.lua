-- Configuration
local CENTER_X, CENTER_Y, CENTER_Z = 1205, 128, -1527
local HORIZ_RANGE = 64
local REDSTONE_SIDE = "back"
local POLL_INTERVAL = 7

local detector = peripheral.find("player_detector")

if not detector then
	print("Player Detector not found!")
end

-- Helper function to update the monitor display
local function updateDisplay(isActive, detectedPlayers)
	if not monitor then
		return
	end

	monitor.setTextScale(1)
	monitor.setBackgroundColor(colors.black)
	monitor.clear()

	-- Header
	monitor.setCursorPos(2, 2)
	monitor.setTextColor(colors.lightGray)
	monitor.write("FLIGHT PYLON STATUS")

	-- Status Indicator
	monitor.setCursorPos(2, 4)
	if isActive then
		monitor.setTextColor(colors.lime)
		monitor.write("STATE: ONLINE")
	else
		monitor.setTextColor(colors.red)
		monitor.write("STATE: STANDBY")
	end

	-- Detected Players List
	monitor.setCursorPos(2, 6)
	monitor.setTextColor(colors.white)
	if #detectedPlayers > 0 then
		monitor.write("In Range: " .. table.concat(detectedPlayers, ", "))
	else
		monitor.write("In Range: None")
	end
end

print("Flight Pylon Horizontal Boundary Guard Online.")

while true do
	local players = detector.getPlayersInRange(
		CENTER_X - HORIZ_RANGE,
		-1000,
		CENTER_Z - HORIZ_RANGE,
		CENTER_X + HORIZ_RANGE,
		2000,
		CENTER_Z + HORIZ_RANGE
	)

	local playerDetected = #players > 0
	if playerDetected then
		redstone.setOutput(REDSTONE_SIDE, true)
	else
		redstone.setOutput(REDSTONE_SIDE, false)
	end

	os.sleep(POLL_INTERVAL)
end
