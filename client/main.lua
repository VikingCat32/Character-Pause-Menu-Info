------------------------------------------------------------------------------------------------

QBCore = exports['qb-core']:GetCoreObject()

local PlayerName = nil
local cashAmount = 0
local bankAmount = 0

------------------------------------------------------------------------------------------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler("QBCore:Client:OnPlayerLoaded",function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        cashAmount = PlayerData.money['cash']
        bankAmount = PlayerData.money['bank']
    end)
    QBCore.Functions.TriggerCallback('chicle_pause_menu:getPlayerName', function(cb) PlayerName = cb end)

end)

------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    local IsPauseMenu = false

    while true do
        Wait(0)

        if IsPauseMenuActive() then
            if not isPauseMenu then
                isPauseMenu = true
                QBCore.Functions.GetPlayerData(function(PlayerData)
                    cashAmount = PlayerData.money['cash']
                    bankAmount = PlayerData.money['bank']
                end)

                if PlayerName == nil then
                    QBCore.Functions.TriggerCallback('chicle_pause_menu:getPlayerName', function(cb)
                        PlayerName = cb
                    end)
                end
            end

              -- Space for the subtitle
              BeginScaleformMovieMethodOnFrontendHeader("SHIFT_CORONA_DESC")
              PushScaleformMovieFunctionParameterBool(true)
              PushScaleformMovieFunctionParameterBool(true)
              PopScaleformMovieFunction()

              -- The title text
              BeginScaleformMovieMethodOnFrontendHeader("SET_HEADER_TITLE")
              PushScaleformMovieFunctionParameterString(Config.title)
              PushScaleformMovieFunctionParameterBool(true)

              -- The subtitle text
              PushScaleformMovieFunctionParameterString(Config.subtitle)
              PushScaleformMovieFunctionParameterBool(true)
              PopScaleformMovieFunctionVoid()

              BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
              PushScaleformMovieFunctionParameterString(PlayerName)
              PushScaleformMovieFunctionParameterString((Config.cash_text):format(cashAmount))
              PushScaleformMovieFunctionParameterString((Config.bank_text):format(bankAmount))
              ScaleformMovieMethodAddParamBool(false)
              ScaleformMovieMethodAddParamBool(isScripted)
              EndScaleformMovieMethod() 
              
        else
            if isPauseMenu then
                isPauseMenu = false
            end
        end
    
    end

end)

------------------------------------------------------------------------------------------------
