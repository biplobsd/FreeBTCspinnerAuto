--[[
# FreeBTCspinerAuto
FreeBTCspinerAuto is an automation script using Ankulua like Pokemon GO Plus.

## Environment
- OS: Android
- Automation Environment: Ankulua
- Language: Lua
- Ankulua Website:
English: http://ankulua.boards.net/; 
Chinese: http://ankulua-tw.boards.net/

## Features:
- Wait for app home page.
- while Low energy detected then stop.
- Setting Timer on 2.9m then stop.

## Disclaimer:
- This script may be officially detected and the game account will be dismissed in violation of the Terms of Service.
- I am not responsible for any loss caused by the use of this script.
- If you want to use it, please bear any possible losses.

## Tested Device: 
Xiaomi redmi 4 prime

# Coded By BiplobSD a.k.a άλφα 4D

version = "1.0"
--]]
-- ========== Settings ================

-- Globle Variables Setup 
setImmersiveMode(true)
Settings:setCompareDimension(true, 1080)
Settings:setScriptDimension(true, 1080)

-- Region config
waitf = Region(277,1313, 373, 209)
LCheck = Region(228, 93, 207, 87)
offer1 = Region(137, 495, 45, 57)
spin = Region(762, 1709, 62, 22)

-- environment setup
dir = scriptPath();
setImagePath(dir .. "image")

-- Veriable
offer = 2 -- 0 for check offer popup message. set 2 for not check offer popup
timer = Timer();
-- ========== Function ================


-- ========== Main Program ================
timer:set()

while waitf:exists(Pattern("Wel_W.png"), 0) do 
    wait(3)
    toast("Wait")
    toast(timer:check() .. " sec")
    if timer:check() >= 205.361 then
        toast("You have maybe internet problem. so your app need more time for load app. \nRuntime: " .. timer:check()/60 .. " minutes" .. "\n\nVersion: 1.0")
        break
    end
end

while not LCheck:exists(Pattern("Low_W.png"), 0.4) do
    spinsave = spin:exists(Pattern("spin.png"), 0)
    if spinsave ~= nil then
        click(Location(752, 1704))
        click(Location(752, 1704))
    else
        toast("Spin not Found. Wait")
        break
    end
    -- if conE:exists("Connection_error.png") then
    -- 	toast("Connection error found")
    -- 	click(Location(877, 1111))
    -- end
    if offer < 1 then
        offersave = offer1:exists(Pattern("of_1.png"), 0)
         if offersave ~= nil then
            toast("Offer found")
            click(Location(325, 1405))
            offer = 2
        end
    end
    if timer:check() >= 205.361 then
        toast("You have maybe internet problem. so your app need more time for load app. \nRuntime: " .. timer:check()/60 .. " minutes" .. "\n\nVersion: 1.0")
        break
    end
end

toast(timer:check())
if waitf:exists(Pattern("Wel_W.png"), 0) or LCheck:exists(Pattern("Low_W.png"), 0.4) or spin:exists(Pattern("spin.png"), 0) then
    scriptExit("Low energy detected. So stop. \nRuntime: " .. timer:check()/60 .. " minutes" .. "\n\nVersion: 1.0")
else
    scriptExit("It's not look like free btc spiner app. \nRuntime: " .. timer:check()/60 .. " minutes" .. "\n\nVersion: 1.0")
end
