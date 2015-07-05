require "smalruby"

init_hardware
cat1 = Character.new(costume: "cat3.png", x: 70, y: 228, angle: 0)
cat2 = Character.new(costume: "cat1.png", x: 394, y: 98, angle: 0)
frog1 = Character.new(costume: "frog1.png", x: 396, y: 264, angle: 0)
# ダブルセンサー

猫X = 0
猫Y = 0


cat1.on(:start) do
  loop do
    猫X = (sensor("A0").value - 100) / 2
    猫Y = sensor("A1").value - 100
    self.position = [猫X, 猫Y]
  end
end


cat2.on(:start) do
  loop do
    say(message: sensor("A0").value)
  end
end


frog1.on(:start) do
  loop do
    say(message: sensor("A1").value)
  end
end
