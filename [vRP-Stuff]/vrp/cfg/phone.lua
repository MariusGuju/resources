
local cfg = {}

-- size of the sms history
cfg.sms_history = 15

-- maximum size of an sms
cfg.sms_size = 500

-- duration of a sms position marker (in seconds)
cfg.smspos_duration = 300

-- define phone services
-- blipid, blipcolor (customize alert blip)
-- alert_time (alert blip display duration in seconds)
-- alert_permission (permission required to receive the alert)
-- alert_notify (notification received when an alert is sent)
-- notify (notification when sending an alert)
cfg.services = {
  ["Politia Romana"] = {
    blipid = 304,
    blipcolor = 38,
    alert_time = 30, -- 5 minutes
    alert_permission = "police.service",
    alert_notify = "~r~Dipecerat Politie:~n~~s~",
    notify = "~b~Ai sunat la 112.",
    answer_notify = "~b~Politia va sosi in curand."
  },
  ["Ambulanta"] = {
    blipid = 153,
    blipcolor = 1,
    alert_time = 30, -- 5 minutes
    alert_permission = "emergency.service",
    alert_notify = "~r~Emergency alert:~n~~s~",
    notify = "~b~Ai chemat o ambulanta.",
    answer_notify = "~b~Ambulanta va sosi curand!."
  },
  ["Taxi Pelican"] = {
    blipid = 198,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "taxi.service",
    alert_notify = "~y~Dispecerat Taxi:~n~~s~",
    notify = "~b~Ai sunat la Taxi Pelican.",
    answer_notify = "~y~Un pelican zboara spre tine."
  },
  ["Taxi Pelican"] = {
    blipid = 198,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "taxi.service",
    alert_notify = "~y~Dispecerat Taxi:~n~~s~",
    notify = "~b~Ai sunat la Taxi Pelican.",
    answer_notify = "~y~Un pelican zboara spre tine."
  },
  ["Hitman"] = {
    blipid = 198,
    blipcolor = 5,
    alert_time = 30, -- 1 minutes
    alert_permission = "hitman.service",
    alert_notify = "~y~Alerta de Hitman:~n~~s~",
    notify = "~y~Ai sunat la hitman.",
    answer_notify = "~y~Un Agent Hitman ti-a acceptat comanda."
  },
  ["Mecanic"] = {
    blipid = 446,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "repair.service",
    alert_notify = "~y~Don mecanic e nevoie de tine:~n~~s~",
    notify = "~y~Ai sunat la Dorel Vulcanizare.",
    answer_notify = "~y~Un mecanic va sosi in curand!"
  },
   ["Traficant de arme"] = {
    blipid = 198,
    blipcolor = 5,
    alert_time = 300, -- 1 minutes
    alert_permission = "traficant.service",
    alert_notify = "~y~Alerta de Traficant:~n~~s~",
    notify = "~y~Ai sunat la Traficant.",
    answer_notify = "~y~Un Traficant ti-a acceptat comanda."
  }
}

-- define phone announces
-- image: background image for the announce (800x150 px)
-- price: amount to pay to post the announce
-- description (optional)
-- permission (optional): permission required to post the announce
cfg.announces = {
  ["admin"] = {
    --image = "nui://vrp_mod/announce_admin.png",
    image = "https://th.bing.com/th/id/R9a98edd620351d2cb676933edf4e0513?rik=8lucPC5KvkGNqQ&pid=ImgRaw",
    price = 0,
    description = "Anunt pentru admini",
    permission = "admin.announce"
  },
  ["police"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "https://cdn.discordapp.com/attachments/786720515938582609/786779798676045854/anuntgarda.png",
    price = 0,
    description = "Anunt din partea politiei! Aveti grija",
    permission = "police.announce"
  },
  ["commercial"] = {
    --image = "nui://vrp_mod/announce_commercial.png",
    image = "https://th.bing.com/th/id/R2fbfd072307e825942f67629efb621ff?rik=ofUtLq7DB4kzSg&pid=ImgRaw",
    description = "Lucruri comerciale (cumpar,vand,munca,etc).",
    price = 150
  },
  ["party"] = {
    --image = "nui://vrp_mod/announce_party.png",
    image = "https://th.bing.com/th/id/OIP.ZweVeTJiCtov6PWUspYquwHaLH?pid=ImgDet&rs=1",
    description = "Organizezi o petrecere? Anunta jucatorii unde e locatia.",
    price = 150
  }
}

return cfg
