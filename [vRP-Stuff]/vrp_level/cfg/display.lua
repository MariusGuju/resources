
local cfg = {}

function cfg.SetXP(xp)
    return ".div_content_xp{position: absolute;top:0:left:0;margin:0;padding:0;height: 100%;width: "..xp.."%;font-weight:bold;font-size: 15px;color: #ffffff;font-family: 'Lucida Consola';font-weight: bold;text-align:center;background: rgb(51, 153, 255);border-radius: 15px;}"
end

cfg.display_css = [[
.div_level{
  position: absolute;
  bottom: 1%;
  font-weight:bold;
  left: 42.125%;
  font-size: 15px;
  color: #ffffff;
  font-family: 'Lucida Consola';
  font-weight: bold;
  text-align:center;
  color: white;
  width: 15.75%;
  height:1.7%;
  border-radius: 15px;
  background-color: rgba(0,0,0,0.7);
  text-shadow: 1px 1px 2px black;
  font-weight:bold;font-size: 15px;color: #ffffff;font-family: 'Lucida Consola';font-weight: bold;text-align:center;
}
.div_level2{
  position: absolute;
  bottom: 1.1%;
  font-weight:bold;
  left: 42.125%;
  font-size: 15px;
  color: #ffffff;
  font-family: 'Lucida Consola';
  font-weight: bold;
  text-align:center;
  color: white;
  width: 15.75%;
  height:1.7%;
  border-radius: 15px;
  text-shadow: 1px 1px 2px black;
}

  ]]

return cfg
