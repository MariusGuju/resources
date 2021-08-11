local cfg = {}

cfg.factions = {
---Guvern----
	["Politie"] = {
		fType = "M.A.I",
		fSlots = 40,
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Agent", salary = 700},  
			[3] = {rank = "Agent Sef", salary = 800},  
			[4] = {rank = "Sub-Inspector", salary = 900},  
			[5] = {rank = "Inspector-Sef", salary = 1000}, 
      		[6] = {rank = "Comisar", salary = 1100}, 
      		[7] = {rank = "Chestor", salary = 1200},    
			[8] = {rank = "Chestor General", salary = 1300}
		}
  },
  ["S.I.A.S"] = {
		fType = "M.A.I",
		fSlots = 20,
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
			[2] = {rank = "Agent S.I.A.S", salary = 700},  
			[3] = {rank = "Agent Sef S.I.A.S", salary = 800},    
			[4] = {rank = "Inspector S.I.A.S", salary = 900}, 
			[5] = {rank = "Comisar S.I.A.S", salary = 1000},
			[6] = {rank = "Comisar Sef S.I.A.S", salary = 1100}, 
			[7] = {rank = "Chestor Secundar S.I.A.S", salary = 1200},  
			[8] = {rank = "Chestor General S.I.A.S", salary = 1300}
		}
	},
	
	["Smurd"] = {
		fType = "Unitatea Primiri Urgente",
		fSlots = 30,
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
			[2] = {rank = "Asistent", salary = 500}, 
			[3] = {rank = "Asistent-Sef", salary = 600},
			[4] = {rank = "Paramedic Smurd", salary = 700}, 
			[5] = {rank = "Chirurg", salary = 800},   
			[6] = {rank = "Sef de Tura SMURD", salary = 900},  
			[7] = {rank = "Sef Spital", salary = 1000},
			[8] = {rank = "Director SMURD", salary = 1100},
		}
	},
------Hitman Legacy----------------
	["Hitman"] = {
		fSlots = 10,
		fType = "Serviciul Criminalistic",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Hitman", salary = 671}, 
			[3] = {rank = "Lider Hitman", salary = 1201}
		}
	},
	
	--Mafii
	
	["Mafia Rusa"] = {
		fSlots = 12,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Rusa", salary = 1},
			[3] = {rank = "Co-Lider Rusa", salary = 1},
			[4] = {rank = "Lider Rusa", salary = 1}
		}
	},
	
	["Mafia Sinaloa Cartel"] = {
		fSlots = 12,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		    [2] = {rank = "Sinaloa Cartel", salary = 1},
			[3] = {rank = "Co-Lider Sinaloa Cartel", salary = 1},
			[3] = {rank = "Lider Sinaloa Cartel", salary = 1}
		}
	},

	["Mafia Siciliana"] = {
		fSlots = 12,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Membru Mafia Siciliana", salary = 1},
			[3] = {rank = "Lider Mafia Siciliana", salary = 1}
		}
	},
	
	["Mafia Peaky Blinders"] = {
		fSlots = 12,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Peaky Blinders", salary = 1},
			[3] = {rank = "Co-Lider Peaky Blinders", salary = 1},
			[4] = {rank = "Lider Peaky Blinders", salary = 1}
		}
	},
	
	["Mafia LosVagos"] = {
		fSlots = 12,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "LosVagos", salary = 1},
			[3] = {rank = "Co-Lider LosVagos", salary = 1},
			[4] = {rank = "Lider LosVagos", salary = 1}
		}
	},

	["Mecanic"] = {
		fSlots = 20,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "Ucenic Mecanic", salary = 1},
			[3] = {rank = "Mecanic", salary = 1},
			[4] = {rank = "Mecanic Sef", salary = 1},
			[5] = {rank = "Responsabil Mecanic", salary = 1},
			[6] = {rank = "Proprietar Service", salary = 1}
		}
	},

	["Mafia SONS OF ANARCHY"] = {
		fSlots = 12,
		fType = "Mafie",
		fRanks = {
			[1] = {rank = "Somer", salary = 1}, 
		  	[2] = {rank = "SONS OF ANARCHY", salary = 1},
			[3] = {rank = "Co-Lider SONS OF ANARCHY", salary = 1},
			[4] = {rank = "Lider SONS OF ANARCHY", salary = 1}
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