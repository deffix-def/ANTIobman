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
            sampAddChatMessage(tag .. '�� ������� {FF0000}��������� {FFFFFF}��������� �� ����������� ������� ���-�����.', -1)
        else
            sampAddChatMessage(tag .. '�� ������� {00FF00}�������� {FFFFFF}��������� �� ����������� ������� ���-�����.', -1)
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
            if text:find('%w+_?%w+ {FFFFFF}���������� ��� ������ � ���� ���������� �����') then
                local player, next_words = text:match('(%w+_?%w+) {FFFFFF}���������� ��� ������ � ���� ���������� ����� (.+)')
                sampAddChatMessage(tag .. '�����{FF66FF} ' .. player .. ' {FFFFFF}��������� ������� ����� ' .. next_words .. ', {FFFFFF}�� � ��� ���������!', -1)
                sampSendDialogResponse(510, 0, _, _)
                return false
            end
        end
    end
end