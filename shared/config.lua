Config  = {}



Config.EntranceTicket = 'bread'
Config.WashingTicket = 'water'
Config.MoneyType = 'black_money'
Config.CleanMoney = 'money'

Config.Zones = {
    WashZone = vec3(vec3(1122.3206, -3193.2749, -40.623)),
    ExitZone = vec3(1138.1576, -3199.1143, -39.6656),
    EntryZone = vec3(1143.4563, -1000.2941, 45.3185),
}

Config.Moneywash = {
    Enter = vec3(1138.1478, -3199.1692, -39.6657),
    Exit = vec4(1144.8295, -1000.2859, 45.2904, 277.0518),

    WashDuration = 30000,
    Cooldown = 1000*600,
    TaxRate = 0.10,
}
