
RegisterServerEvent('stevo_moneywash:server:EndOfWask')
AddEventHandler('stevo_moneywash:server:EndOfWask', function (Amount)

  local Player = source
  local WashingTax = Amount * Config.Moneywash.TaxRate
  local WashingTotal = Amount - WashingTax

  local Ticket = exports.ox_inventory:Search(Player, 'count', Config.WashingTicket)
  local Money = exports.ox_inventory:Search(Player, 'count', Config.MoneyType)

  if Money >= Amount then
    if Ticket >= 1 then
      exports.ox_inventory:RemoveItem(Player, Config.WashingTicket, 1)
      exports.ox_inventory:RemoveItem(Player, Config.MoneyType, Amount)
      Wait(Config.Moneywash.WashDuration)
      exports.ox_inventory:AddItem(Player, Config.CleanMoney, WashingTotal)
    else TriggerClientEvent('ox_lib:notify', Player, {title = locale('title'), description = locale('not_enough_ticket'), type = 'error'}) end
  else TriggerClientEvent('ox_lib:notify', Player, {title = locale('title'), description = locale('not_enough_black_money'), type = 'error'}) end


end)

-- ESX.RegisterServerCallback('checkforkeycard', function(source, cb)
--   local EntranceTicket = exports.ox_inventory:Search(source, 'count', Config.EntranceTicket)
--   if EntranceTicket > 1 then
--       Entrance = true
--       cb(EntranceTicket)
--   else
--     Entrance = false
--       cb(EntranceTicket)
--   end
-- end)







