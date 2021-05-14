-- Lowich#8914

RegisterCommand("kod",function(args,rawCommand)
    TriggerServerEvent("kodudogrula",rawCommand[1])
end)

RegisterNetEvent("gecerlikod")
AddEventHandler("gecerlikod", function()
  exports['mythic_notify']:SendAlert('error', 'Geçerli bir kod giriniz')
end)

RegisterNetEvent("bilgi")
AddEventHandler("bilgi", function()
  exports['mythic_notify']:SendAlert('inform', 'Sadece 1 kere kullanabilirsin!')
end)

RegisterNetEvent("basarili")
AddEventHandler("basarili", function()
  exports['mythic_notify']:SendAlert('success', 'Başarıyla kod kullanıldı.', 2500, { ['background-color'] = '#008000', ['color'] = '#ffffff' })
end)
