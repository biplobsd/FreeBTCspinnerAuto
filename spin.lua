--[[
## Disclaimer:
- This script may be officially detected and the app account will be dismissed in violation of the Terms of Service.
- I am not responsible for any loss caused by the use of this script.
- If you want to use it, please bear any possible losses.

## For more info check : https://github.com/biplobsd/FreeBTCspinnerAuto

coded by biplobsd
--]]
version = "\n\nv1.2"
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
climeS = Region(286, 807, 284, 64)
climeC = Region(131, 755, 171, 71)
climeSuc = Region(297, 793, 259, 57)
PleWait = Region(163, 763, 757, 99)
verifybtcapp = Region(896, 69, 128,132)

-- environment setup
dir = scriptPath();
setImagePath(dir .. "image")

-- User Interface
dialogInit()
newRow()
addCheckBox("ClimeNow", " Set Auto 'Claim Now' after low energy", false)
newRow()
addCheckBox("ClimeNowOnly", " Set only Claim Now.", false)
newRow()
addCheckBox("offer", " Set Offer Check", false)
newRow()
addCheckBox("lerrorC", " Set Location error Check", false)
newRow()
addTextView("Set time eatch app for spin in minutes ")
addEditNumber("timerSET", 3.42)
dialogShow("Setup")

timerSET = timerSET * 60

-- Veriable
-- offer = true -- `true` for check offer popup message. Set `false` for not check offer popup.
-- lerrorC = true -- `true` for check Location error popup message. Set `false` for not check Location error popup.
-- ClimeNow = true -- `true` for check clime now. Set `false` for not check.
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
    if timer:check() >= timerSET then
        scriptExit("You have maybe internet problem. So your app need more time for load app. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
        break
    end
end

    -- Spinning
-----------------
while not LCheck:exists(Pattern("Low_W.png"), 0.4) do
    if (ClimeNowOnly) then
        break
    end
    if ClimeNowOnly == false then
        spinsave = spin:exists(Pattern("spin.png"), 0)
        if spinsave ~= nil then
            click(Location(752, 1704))
            click(Location(752, 1704))
        else
            toast("Spin not Found. Wait")
            break
        end
    end
    -- Offer Check
-----------------
    if (offer) then
        offersave = offer1:exists(Pattern("of_1.png"), 0)
         if offersave ~= nil then
            toast("Offer found")
            click(Location(325, 1405))
            offer = 1
        end
    end

    -- Locotion error Check
-----------------
    if (lerrorC) then
         if lerrorR:exists(Pattern("Lerror.png"), 0) then
            scriptExit("A non-US location detected. So stop. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
        end
    end

    -- timer end
-----------------
    if ClimeNowOnly == false then
        if timer:check() >= timerSET then
            toast("Time is over. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
            break
        end
    end
end

wait(0.1)

        -- Clime Now
-----------------
if (ClimeNow) or (ClimeNowOnly) then
    if LCheck:exists(Pattern("Low_W.png"), 0.4) or verifybtcapp:exists(Pattern("vRfy.png"), 0) then
        toast("Try to Claim Satoshi")
        click(Location(99, 136))
        click(Location(99, 136))
        wait(0.3)
        click(Location(99, 136))
        if climeS:exists(Pattern("climenowB.png"), 0) then
            toast("Claim Now found")
            click(Location(439, 846))
            wait(0.3)
            if climeC:exists(Pattern("climenow_Confirm.png"), 0) then
                click(Location(747, 1143))
                while PleWait:exists(Pattern("plz_wait.png"), 0) do
                    wait(0.5)
                    toast("Wait for payment")
                end
                if climeSuc:exists(Pattern("climeSucZ.png"), 0) then
                    scriptExit("Claim Success! \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
                end
            end
        else
            scriptExit("Wait for 3 day. Then Claim. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
        end
    end
end

    -- Verify condition 
-----------------
toast(timer:check())
if timer:check() >= timerSET then
    scriptExit("Time is over. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
end
if waitf:exists(Pattern("Wel_W.png"), 0) or LCheck:exists(Pattern("Low_W.png"), 0.4) or spin:exists(Pattern("spin.png"), 0) then
    scriptExit("Low energy detected. So stop. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
else
    scriptExit("It's not look like free btc spiner app. \nRuntime: " .. timer:check()/60 .. " minutes" .. version)
end
