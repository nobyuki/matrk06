require "smalruby"

cat2 = Character.new(costume: "cat3.png", x: 252, y: 384, angle: 0)
ball1 = Character.new(costume: "ball6.png", x: 294, y: 216, angle: 225, rotation_style: :left_right)
cat1 = Character.new(costume: "cat2.png", x: 0, y: 192, angle: 0, rotation_style: :left_right)
frog1 = Character.new(costume: "frog1.png", x: 544, y: 220, angle: 211, rotation_style: :left_right)
回数 = 0

打った人 = ""


cat2.on(:start) do
  loop do
    say(message: 回数)
  end
end


ball1.on(:start) do
  loop do
    move(10 + 回数)
    turn_if_reach_wall
    if x >= 608
      cat1.say(message: "勝った！")
      break
    end
    if x <= 0
      cat1.say(message: "負けた・・・")
      break
    end
  end
end


ball1.on(:hit, cat1) do
  if !(打った人 == "cat1")
    turn_x
    打った人 = "cat1"
    回数 = 回数 + 1
  end
end

ball1.on(:hit, frog1) do
  if !(打った人 == "frog1")
    turn_x
    打った人 = "frog1"
    回数 = 回数 + 1
  end
end


cat1.on(:key_down, K_UP) do
  self.y += -10
end

cat1.on(:key_down, K_DOWN) do
  self.y += 10
end


frog1.on(:start) do
  loop do
    if ball1.y >= y
      self.y += 10
    else
      self.y += -10
    end
  end
end
