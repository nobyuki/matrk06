require "smalruby"

cat2 = Character.new(costume: "cat3.png", x: 272, y: 1, angle: 0, rotation_style: :left_right)
init_hardware
cat1 = Character.new(costume: "cat2.png", x: 0, y: 182, angle: 0, rotation_style: :left_right)
ball1 = Character.new(costume: "ball6.png", x: 304, y: 220, angle: 225, rotation_style: :left_right)
frog1 = Character.new(costume: "frog1.png", x: 544, y: 183, angle: 180, rotation_style: :left_right)
# ダブルセンサーピンポン

猫X = 0
猫Y = 0

hit_by = ""
回数 = 0

猫X_直前 = 猫X


cat2.on(:start) do
  self.pen_color = [255, 0, 0]
  self.angle = 90
  down_pen
  until reach_wall?
    say(message: "レディ・・・")
    move(20)
    await
  end
  say(message: "ゴー！！！")
  sleep(1)
  loop do
    say(message: 回数)
  end
end


cat1.on(:start) do
  loop do
    猫X_直前 = 猫X
    猫X = (sensor("A0").value - 100) / 2
    if 猫X > 224
      猫X = 224
    end
    猫Y = sensor("A1").value - 100
    self.position = [猫X, 猫Y]
  end
end


ball1.on(:start) do
  sleep(2)
  loop do
    move(10 + 回数)
    turn_if_reach_wall
    if x >= 608
      cat1.say(message: "勝った！")
      break
    end
    if x <= 0
      cat1.say(message: "負けたー")
      break
    end
  end
end


ball1.on(:hit, frog1) do
  if !(hit_by == "frog1")
    hit_by = "frog1"
    回数 = 回数 + 1
    turn_x
  end
end


frog1.on(:start) do
  loop do
    if y >= ball1.y
      self.y += -20
    else
      self.y += 20
    end
  end
end


ball1.on(:hit, cat1) do
  if !(hit_by == "cat1")
    hit_by = "cat1"
    回数 = 回数 + 1
    if 猫X > 猫X_直前
      self.angle = rand(-45..45)
    else
      turn_x
    end
  end
end
