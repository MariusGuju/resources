
local cfg = {}

--[[
cfg.display_css = [[
  /* Mission   Amorim#0567 



  @font-face {
    src: url("../poppins.ttf");
    font-family: poppins;
  }    
      @-webkit-keyframes animate {
    0% {
      opacity: 0;
    }
    100% {
      opacity: 1;
    }
  }
  @keyframes animate {
    0% {
      opacity: 0;
    }
    100% {
      opacity: 1;
    }
  }
    
  .div_mission{
    position: absolute;
    -webkit-animation: animate 1s;
    animation: animate 1s;
    top: 22%;
    right: 1%;
    font-size: 0.7em;
    text-align: justify;
    background-color: rgba(30, 30,30,.5);
    color: white;
    padding: 6px;
    border-bottom: 2px solid rgb(0,215,255);;
    border-radius: 4px;
    max-width:450px;
  }
  
  .div_mission .name{
    font-weight: 500;
    margin-bottom: 2px;
    text-align: justify;
    color: white;
    font-size: 1.2em;
    font-family: poppins;
  }
  
  .div_mission .step{
    text-transform: uppercase;
    font-size: 1.3em;
    color: rgb(250, 3, 3);
  }
]]

--]]

return cfg
