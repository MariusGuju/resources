
RS.eventsProtection = true -- Masterswitch
RS.events_antifakename = true -- Detects cheaters trying to abuse events to send fake messages (Recommended)

RS.events_blacklistedeventsprotection = true -- Detects and Ban Blacklisted Events
RS.events_blacklistedevents = {
    "HCheat:TempDisableDetection",
    "FAC:EzExec"
}

RS.events_antispam = true -- Detects and ban events spamming from the list below
RS.events_antispam_maxevents = 15 -- Max 15 events x 10 seconds

RS.events_list = {
    ["esx_fueldelivery:pay"] = 1000, -- max Value (Money)
    ["esx_carthief:pay"] =  1000,
    ["esx_godirtyjob:pay"] = 1000,
    ["esx_pizza:pay"] = 1000,
    ["esx_ranger:pay"] = 1000,
    ["esx_garbagejob:pay"] = 1000,
    ["esx_gopostaljob:pay"] = 1000,
    ["esx_slotmachine:sv:2"] = 1000,
    ["esx_dmvschool:pay"] = 1000,
    ["esx_tankerjob:pay"] = 1000,
    ["AdminMenu:giveBank"] = 1000,
    ["AdminMenu:giveCash"] = 1000,
    ["LegacyFuel:PayFuel"] = 1000,
    ["ljail:jailplayer"] = true, -- Only Spam Protection
    ["esx_jailer:sendToJail"] = true, -- Only Spam Protection
    ["js:jailuser"] = -1, -- USE -1 FOR JAIL EVENTS
    ["esx_jail:sendToJail"] = -1, -- USE -1 FOR JAIL EVENTS
    ["esx-qalle-jail:jailPlayer"] = -1, -- USE -1 FOR JAIL EVENTS
    ["esx_communityservice:sendToCommunityService"] = -1 -- USE -1 FOR JAIL EVENTS
}
