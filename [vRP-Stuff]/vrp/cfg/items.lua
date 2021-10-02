-- define items, see the Inventory API on github

local cfg = {}
-- see the manual to understand how to create parametric items
-- idname = {name or genfunc, description or genfunc, genfunc choices or nil, weight or genfunc}
-- a good practice is to create your own item pack file instead of adding items here
cfg.items = {
  ["benzoilmetilecgonina"] = {"Benzoilmetilecgonina", "Some Benzoic acid ester.", nil, 0.01}, -- no choices
  ["seeds"] = {"Seeds", "Some Weed seeds.", nil, 0.01}, -- no choices
  ["iarba"] = {"iarba", "Droage.", nil, 0.01}, -- no choices
  ["lsd"] = {"lsd", "Droage.", nil, 0.01}, -- no choices
  ["Mandat"] = {"Mandat", "Mandat.", nil, 0.01}, -- no choices
  ["cocaine"] = {"Cocaina", "Droage.", nil, 0.01}, -- no choices
  ["harness"] = {"Harness", "Some Harness Lysergsäurediethylamid.", nil, 0.01}, -- no choices
  ["AK47"] = {"AK47", "A Russian masterpeice.", nil, 0.01}, -- no choices
  ["M4A1"] = {"M4A1", "Helps give non-Americans freedom.", nil, 0.01}, -- no choices
  ["credit"] = {"Stolen Credit Card", "Credit card.", nil, 0.01}, -- no choices
  ["driver"] = {"Driver license Card", "license card.", nil, 0.01}, -- no choices
  ["bank_money"] = {"Money of bank", "$.", nil, 0},
  ["trash"] = {"Trash", "It fucking stinks!", nil, 0},  -- no choices
  ["fake_id"] = {"Fake ID", "It just says Mcluvin.", nil, 0}, -- no choices
  ["police_report"] = {"Police Report", "Take it to the Bank Manager.", nil, 0},  -- no choices
  ["ems_report"] = {"EMS Report", "Take it to the Hospital.", nil, 0}, -- no choices
  ["cargo"] = {"Cargo", "Boxes full of porn.", nil, 0}, -- no choices
  ["mapa"] = {"Mapa", "Item folosit pentru harta", nil, 0}, -- no choices
  ["lapte"] = {"Lapte", "Laptiq.", nil, 0}, -- no choices
  ["Borsec"] = {"Borsec", "Borsec", nil, 0}, -- no choices
  ["Vin"] = {"Vin", "Vin.", nil, 0}, -- no choices
  ["apa"] = {"Apa", nil, 0}, -- no choices
  ["Teddy"] = {"Teddy", "Suculet", nil, 0}, -- no choices
  ["Limonada"] = {"Limonada", "Limonada", nil, 0}, -- no choices
  ["Vodka"] = {"Vodka", "Vodka", nil, 0}, -- no choices
  ["Paine"] = {"Paine", "Paine", nil, 0}, -- no choices
  ["Popcorn"] = {"Popcorn", "Popcorn", nil, 0}, -- no choices
  ["Spaghete"] = {"Spaghete", "Spaghete.", nil, 0}, -- no choices
  ["Pizza"] = {"Pizza", "", nil, 0}, -- no choices
  ["Gogoasa"] = {"Gogoasa", "", nil, 0}, -- no choices
  ["c4"] = {"c4", "Explozibil", nil, 0}, -- no choices
  ["radio"] = {"radio", "Radio", nil, 0}, -- no choices
  ["body_armor"] = {"Vesta Anti-Glont", "Vesta Anti-Glont", nil, 0}, -- no choices
  ["lockpick"] = {"Lockpick", "Item folosit pentru spargerea masinilor", nil, 0}, -- no choices
  ["carne"] = {"Carne de Vaca", "Carnea o poti vinde la Piata (KG)", nil, 0},
  ["caras"] = {"Peste Caras", "", nil, 0},
  ["platica"] = {"Peste Platica", "", nil, 0},
  ["rosioara"] = {"Peste Rosioara", "", nil, 0},
  ["biban"] = {"Peste Biban", "", nil, 0},
  ["salau"] = {"Peste Salau", "", nil, 0},
  ["rac"] = {"Rac", "", nil, 0},
  ["somn"] = {"Somn", "", nil, 0},
  ["pisicademare"] = {"Pisica de mare", "", nil, 0}, 
  ["drug_cansativa"] = {"Cannabis Sativa", "Esenta de canabis folosita pentru crearea drogurilor puternice",nil,0.5,"pocket"},
	["drug_cocaalka"] = {"Cocaina Alkaloid", "Un lighid albastru extras din planta coca",nil,0.7,"pocket"},
	["drug_unprocpcp"] = {"PCP Neprocesat", "Praf alb de PCP neprocesat",nil,0.6,"pocket"},
  ["drug_lyseracid"] = {"Acid Lysergic", "Substanta puternica din seminte de Turbina Corymbosa",nil,0.8,"pocket"},
  -----------------------
  ["minereunecunoscut"] = {"Minereu Necunoscut", "" ,nil,0.4,"pocket"},
	["minereucurat"] = {"Minereu Spalat", "" ,nil,0.4,"pocket"},
	["diamant"] = {"Bucati de Diamant", "" ,nil,0.4,"pocket"},
	["aur"] = {"Bucati de Aur", "" ,nil,0.4,"pocket"},
	["argint"] = {"Bucati de Argint", "" ,nil,0.4,"pocket"},
	["piatra"] = {"Bucati de Piatra", "" ,nil,0.4,"pocket"},
	["lingoudiamant"] = {"Lingou Diamant", "" ,nil,5.0,"pocket"},
	["lingouaur"] = {"Lingou Aur", "" ,nil,5.0,"pocket"},
	["lingouargint"] = {"Lingou Argint", "" ,nil,5.0,"pocket"},
  ["piatrafull"] = {"Piatra", "" ,nil,5.0,"pocket"}, 
  -------------------------
  ["voucher"] = {"Voucher", "Cu acest Voucher aveti 5% reducere la orice de pe shop-ul nostru \nCu acest item va duceti la Zedu / EskaPe" ,nil,5.0,"pocket"},
  ["customtag"] = {"Custom Tag", "Cu acest item te duci la Zedu / EskaPe pentru a personaliza gradul. ",nil,5.0,"pocket"},
  -------------------------
  ["Skimmer"] = {"Masinuta cu Telecomanda", "Masinutza lui Zedu ",nil,5.0,"pocket"},
  --- ESK DRUG SYSTEM
  ["iarba"] = {"Iarba", "Cateva grame de iarba culese dintr-o planta!", nil, 1.0},
  ["stack_iarba"] = {"Stash De Iarba", "Stash de iarba", nil, 7.5},
  ["cocaina"] = {"Cocaina", "Cateva grame de cocaina", nil, 3.0},
  ["stack_cocaina"] = {"Stash de Cocaina", "Stash de Cocaina", nil, 15.75},
  ["metanfetamina"] = {"Metanfetamina", "Cateva grame de metanfetamina", nil, 2.5},
  ["stack_metanfetamina"] = {"Stash De Metanfetamina", "Stash de Metanfetamina", nil, 12.75},
  ["lemnne"] = {"Lemne", "O bugata de lemn", nil, 1.0},
  ["lemnpre"] = {"Lemne Prelucrate", "O bugata de lemn", nil, 1.5},
  ["scaunlemn"] = {"Scaun Din Lemn", "Un Scaun Din Lemn", nil, 2.0},
  ["masalemn"] = {"Masa de Lemn", "O Masa din Lemn", nil, 2.0},
}
--“body_armor”,“Vesta Anti-Glont”,“Vest Anti-Glont.”,

-- load more items function
local function load_item_pack(name)
  local items = module("cfg/item/"..name)
  if items then
    for k,v in pairs(items) do
      cfg.items[k] = v
    end
  else
    print("[vRP] item pack ["..name.."] not found")
  end
end

-- PACKS
load_item_pack("required")
load_item_pack("food")
load_item_pack("drugs")

return cfg
