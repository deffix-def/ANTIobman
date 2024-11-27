script_author('deffix | Denis_Mansory')

require 'lib.moonloader'
local inicfg = require('inicfg')
local sampev = require('lib.samp.events')

local tag = "{FF66FF}[ao_simka]: {FFFFFF}"

local inicfgfile = "..//ao_simka.ini"
local inisettings = inicfg.load(inicfg.load({
    settings = {
        simka_antiobman = true
    }
}, inicfgfile))
inicfg.save(inisettings, inicfgfile)


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    sampRegisterChatCommand('ao_simka', function() 
        if inisettings.settings.simka_antiobman then
            sampAddChatMessage(tag .. 'Вы успешно {FF0000}отключили {FFFFFF}автоотказ на предложение покупки сим-карты.', -1)
        else
            sampAddChatMessage(tag .. 'Вы успешно {00FF00}включили {FFFFFF}автоотказ на предложение покупки сим-карты.', -1)
        end
        inisettings.settings.simka_antiobman = not inisettings.settings.simka_antiobman
        inicfg.save(inisettings, inicfgfile)
    end)
    while true do
        wait(0)
    end
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if inisettings.settings.simka_antiobman then
        if id == 510 then
            if text:find('%w+_?%w+ {FFFFFF}предлагает Вам купить у него телефонный номер') then
                local player, next_words = text:match('(%w+_?%w+) {FFFFFF}предлагает Вам купить у него телефонный номер (.+)')
                sampAddChatMessage(tag .. 'Игрок{FF66FF} ' .. player .. ' {FFFFFF}предложил покупку симки ' .. next_words .. ', {FFFFFF}но у Вас автоотказ!', -1)
                sampSendDialogResponse(510, 0, _, _)
                return false
            end
        end
    end
end