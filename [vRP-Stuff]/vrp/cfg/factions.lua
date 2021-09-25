local cfg = {}

cfg.factions = {
---Guvern----
	["Politie"] = {
		fType = "M.A.I",
		fSlots = 40,
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Agent", salary = 700},  
			[3] = {rank = "Sub-Ofiter", salary = 800},  
			[4] = {rank = "Ofiter", salary = 900},  
			[5] = {rank = "Inspector", salary = 1000}, 
      		[6] = {rank = "Comisar", salary = 1100}, 
      		[7] = {rank = "Chestor Principal", salary = 1200},    
			[8] = {rank = "Chestor General", salary = 1300}
		}
  },
  ["S.I.A.S"] = {
		fType = "M.A.I",
		fSlots = 30,
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
			[2] = {rank = "Recrut S.I.A.S", salary = 700},  
			[3] = {rank = "Agent Sef S.I.A.S", salary = 800},    
			[4] = {rank = "Caporal S.I.A.S", salary = 900}, 
			[5] = {rank = "Sergent S.I.A.S", salary = 1000},
			[6] = {rank = "Co-Genral S.I.A.S", salary = 1100}, 
			[7] = {rank = "General S.I.A.S", salary = 1200}
		}
	},
	
	["Smurd"] = {
		fType = "Unitatea Primiri Urgente",
		fSlots = 30,
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
			[2] = {rank = "Asistent", salary = 500}, 
			[3] = {rank = "Paramedi", salary = 600},
			[4] = {rank = "Chirurg", salary = 700}, 
			[5] = {rank = "Sef-Adjunct Spital", salary = 800},   
			[6] = {rank = "Sef Spital", salary = 900}
		}
	},
------Hitman Legacy----------------
	["Hitman"] = {
		fSlots = 10,
		fType = "Serviciul Criminalistic",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Rang A", salary = 671}, 
			[3] = {rank = "Rang B", salary = 1201},
			[4] = {rank = "Rang S", salary = 1201},
			[5] = {rank = "Co-Lider Hitman", salary = 1201},
			[6] = {rank = "Lider Hitman", salary = 1201}

		}
	},
	
	--Mafii
	
	["Groove Street"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Sageata Grove Street", salary = 1},
			[3] = {rank = "Membru Grove Street", salary = 1},
			[4] = {rank = "Camatar Grove Street", salary = 1},
			[5] = {rank = "Interlop Grove Street", salary = 1},
			[6] = {rank = "Co-Lider Grove Street", salary = 1},
			[7] = {rank = "Lider Grove Street", salary = 1}
		}
	},
	
	["Crips"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Sageata Crips", salary = 1},
			[3] = {rank = "Membru Crips", salary = 1},
			[4] = {rank = "Camatar Crips", salary = 1},
			[5] = {rank = "Interlop Crips", salary = 1},
			[6] = {rank = "Co-Lider Crips", salary = 1},
			[7] = {rank = "Lider Crips", salary = 1}
		}
	},

	["Mafia Siciliana"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Membru Mafia Siciliana", salary = 1},
			[3] = {rank = "Lider Mafia Siciliana", salary = 1}
		}
	},
	
	["Mafia Peaky Blinders"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Peaky Blinders", salary = 1},
			[3] = {rank = "Co-Lider Peaky Blinders", salary = 1},
			[4] = {rank = "Lider Peaky Blinders", salary = 1}
		}
	},
	
	["Peaky Blinders"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Sageata Peaky Blinders", salary = 1},
			[3] = {rank = "Membru Peaky Blinders", salary = 1},
			[4] = {rank = "Camatar Peaky Blinders", salary = 1},
			[5] = {rank = "Interlop Peaky Blinders", salary = 1},
			[6] = {rank = "Co-Lider Peaky Blinders", salary = 1},
			[7] = {rank = "Lider Peaky Blinders", salary = 1}
		}
	},

	["Mecanic"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 100001}, 
		  	[2] = {rank = "Ucenic Mecanic", salary = 400001},
			[3] = {rank = "Mecanic", salary = 650001},
			[4] = {rank = "Responsabil Mecanic", salary = 800001},
			[5] = {rank = "Mecanic Sef", salary = 1250001},
			[6] = {rank = "Proprietar Service", salary = 1750001}
		}
	},

	["Casa De Papel"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Sageata Casa de Papel", salary = 1},
			[3] = {rank = "Membru Casa de Papel", salary = 1},
			[4] = {rank = "Camatar Casa de Papel", salary = 1},
			[5] = {rank = "Interlop Casa de Papel", salary = 1},
			[6] = {rank = "Co-Lider Casa de Papel", salary = 1},
			[7] = {rank = "Lider Casa de Papel", salary = 1}
		}
	},

	["Cosa Nostra"] = {
		fSlots = 30,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Sageata Cosa Nostra", salary = 1},
			[3] = {rank = "Membru Cosa Nostra", salary = 1},
			[4] = {rank = "Camatar Cosa Nostra", salary = 1},
			[5] = {rank = "Interlop Cosa Nostra", salary = 1},
			[6] = {rank = "Co-Lider Cosa Nostra", salary = 1},
			[7] = {rank = "Lider Cosa Nostra", salary = 1}
		}
	},

	
	----gang

	["Mafia Bloodz"] = {
		fSlots = 6,
		fType = "gang",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Bloodz", salary = 1},
			[3] = {rank = "Co-Lider Bloodz", salary = 1},
			[4] = {rank = "Lider Bloodz", salary = 1}
		}
	},

	["Mafia Curcubeu"] = {
		fSlots = 12,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Curcubeu", salary = 1},
			[3] = {rank = "Co-Lider Curcubeu", salary = 1},
			[4] = {rank = "Lider Curcubeu", salary = 1}
		}
	}
}

return cfg