-- Configuration
local CENTER_X, CENTER_Y, CENTER_Z = 1205, 128, -1527
local HORIZ_RANGE = 64
local REDSTONE_SIDE = "back"
local POLL_INTERVAL = 7

local detector = peripheral.find("playerDetector")

if not detector then
	error("Player Detector not found!")
end

print("Flight Pylon Horizontal Boundary Guard Online.")

while true do
	local players = detector.getPlayersInBox(
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
