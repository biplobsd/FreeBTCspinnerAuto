--[[
## Disclaimer:
- This script may be officially detected and the app account will be dismissed in violation of the Terms of Service.
- I am not responsible for any loss caused by the use of this script.
- If you want to use it, please bear any possible losses.

## For more info check : https://github.com/biplobsd/FreeBTCspinnerAuto

coded by biplobsd
--]]
version = "\n\nv1.1"
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
lerrorR = Region(595, 845, 183, 75)

-- environment setup
dir = scriptPath();
setImagePath(dir .. "image")

-- Veriable
offer = 1 -- 0 for check offer popup message. set 1 for not check offer popup.
lerrorC = 0 -- 0 for check Location error popup message. set 1 fro not check Location error popup.
timer = Timer();
-- ========== Function ================


-- ========== Main Program ================
timer:set()

    -- Wait for app opening
-----------------
while waitf:exists(Pattern("Wel_W.png"), 0) do 
    wait(3)
    toast("Wait")
    toast(timer:check() .. " sec")
    if timer:check() >= 205.361 then
        toast("You have maybe internet problem. So your app need more time for load app. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
        break
    end
end

    -- Spinning
-----------------
while not LCheck:exists(Pattern("Low_W.png"), 0.4) do
    spinsave = spin:exists(Pattern("spin.png"), 0)
    if spinsave ~= nil then
        click(Location(752, 1704))
        click(Location(752, 1704))
    else
        toast("Spin not Found. Wait")
        break
    end

    -- Offer Check
-----------------
    if offer == 0 then
        offersave = offer1:exists(Pattern("of_1.png"), 0)
         if offersave ~= nil then
            toast("Offer found")
            click(Location(325, 1405))
            offer = 1
        end
    end

    -- Locotion error Check
-----------------
    if lerrorC == 0 then
         if lerrorR:exists(Pattern("Lerror.png"), 0) then
            scriptExit("A non-US location detected. So stop. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
        end
    end

    -- timer end
-----------------
    if timer:check() >= 205.361 then
        scriptExit("Time is over. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
    end
end

    -- Verify condition 
-----------------
toast(timer:check())
if waitf:exists(Pattern("Wel_W.png"), 0) or LCheck:exists(Pattern("Low_W.png"), 0.4) or spin:exists(Pattern("spin.png"), 0) then
    scriptExit("Low energy detected. So stop. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
else
    scriptExit("It's not look like free btc spiner app. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
end
